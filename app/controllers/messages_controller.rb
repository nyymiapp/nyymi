require 'digest/bubblebabble'
require 'securerandom'

class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @message = Message.new
  end

  def create_message(message_params)
    @message = Message.new(message_params)
    @message.user = current_user
    @message.sender_id = current_user.id
    @message.sendername = current_user.username
    @message.seen = false
    @message.save!
    return @message
  end

  def send_interview_invitation
    @message = create_message(message_params)

    @application = Application.find(params[:application_id])
    @application.invitationsended = "true"
    @application.save!

    id=@message.receiver_id

    conversation = find_conversation(id, @message)
    conversation.messages << @message
    conversation.save!

    trigger_seen_messages(conversation)

    # user id pitää olla SE joka ei ole yrityksen ylläpitäjä!
    c = 'message_channel_' + User.find(conversation.user_id).channel

    trigger_new_message(@message, conversation)

    respond_to_message_request(@message)

  end

  def find_conversation(id, message)
    if Conversation.find_by(user_id:id, company_id: @message.company_id ) == nil
        conversation = Conversation.create user_id: id, company_id: @message.company_id, company:Company.find(@message.company_id)
        conversation.user = User.find(id)
        conversation.channel = Digest::SHA256.bubblebabble (@message.content + SecureRandom.hex)
        conversation.userchannel = Digest::SHA256.bubblebabble (@message.content + SecureRandom.hex)
        Company.find(conversation.company_id).users.each do |u|
          c = ConversationChannel.create user_id: u.id, conversation_id:conversation.id, channel:SecureRandom.hex
        end
    else 
        conversation = Conversation.find_by(user_id:id, company_id: @message.company_id )
    end
    return conversation
  end

  def send_message_for_company
    @message = create_message(message_params)

    id=current_user.id

    conversation = find_conversation(id, @message)
    conversation.messages << @message
    conversation.save!

    trigger_seen_messages(conversation)

    trigger_new_message(@message, conversation)

    respond_to_message_request(@message)
  end

  def create
    # Paramseissa tulee aina joko company id tai conversation id.
    @message = create_message(message_params)

    conversation = Conversation.find(message_params[:conversation_id])

    conversation.messages << @message
    conversation.save!

    trigger_seen_messages(conversation)

    # user id pitää olla SE joka ei ole yrityksen ylläpitäjä!

    trigger_new_message(@message, conversation)

    respond_to_message_request(@message)
  end

  def respond_to_message_request(message)
     respond_to do |format|
      if message.save
        format.html { render :show, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: message }
      else
        format.html { render :new }
        format.json { render json: message.errors, status: :unprocessable_entity }
      end
    end
  end

  def trigger_new_message(message, conversation)
    c = 'message_channel_' + User.find(conversation.user_id).channel

    Pusher.trigger(c, 'new_message', {
        message: message.to_json
    })

    conversation.company.users.each do |u|
      if u.id == conversation.user_id
        next
      end
      c = 'message_channel_' + u.channel
      Pusher.trigger(c, 'new_message', {
        message: message.to_json
      })
    end
  end

  def trigger_seen_messages(conversation)
    conversation.company.users.each do |user|
       if ConversationChannel.find_by(user_id:user.id, conversation_id:conversation.id) == nil
        conversationchanneli = ConversationChannel.create user_id: user.id, conversation_id:conversation.id, channel:SecureRandom.hex
       else
        conversationchanneli = ConversationChannel.find_by(user_id:user.id, conversation_id:conversation.id)
       end
       c = 'conversation_channel_' + conversationchanneli.channel

       Pusher.trigger(c, 'set_seen_messages', {
         message: conversation.not_seen(user.id),
         conversation_id: conversation.id
       })

       c = 'user_not_seen_channel_' + user.channel
       Pusher.trigger(c, 'new_not_seen_value', {
         message: user.not_seen,
       })

    end
    c = 'conversation_channel_' + conversation.userchannel

    Pusher.trigger(c, 'set_seen_messages', {
         message: conversation.not_seen(conversation.user.id),
         conversation_id: conversation.id
    })

    c = 'user_not_seen_channel_' + conversation.user.channel
    Pusher.trigger(c, 'new_not_seen_value', {
         message: conversation.user.not_seen,
    })    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :company_id, :conversation_id, :sender_id, :seen, :content, :receiver_id)
    end
end