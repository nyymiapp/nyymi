class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new
    @message.content = params[:content]
    @message.user = current_user
    @message.receiver_id = params[:receiver_id]
    @message.company_id = params[:company_id]
    @message.sender_id = current_user.id
    @message.sendername = current_user.username
    @message.save!

    # user id pitää olla SE joka ei ole yrityksen ylläpitäjä!
    if params[:conversation_id] == nil or params[:conversation_id] == ""
      if @message.company.users.include? current_user and params[:receiver_id] != nil and params[:receiver_id] != "" 
        id = @message.receiver_id
        puts "receiver"
      else 
        id = current_user.id
      end
      if Conversation.find_by(user_id: id, company_id: @message.company_id) == nil
        conversation = Conversation.create user_id: id, company_id: @message.company_id
      else
        conversation = Conversation.find_by(user_id: id, company_id: @message.company_id) == nil
      end
      conversation.messages << @message
      @message.company = Company.find(params[:company_id])
    else 
      conversation = Conversation.find(params[:conversation_id])
      conversation.messages << @message
    end
    conversation.save!

    c = 'message_channel_' + User.find(conversation.user_id).channel

    Pusher.trigger(c, 'new_message', {
        message: @message.to_json
    })

    conversation.company.users.each do |u|
      if u.id == conversation.user_id
        next
      end
      c = 'message_channel_' + u.channel
      Pusher.trigger(c, 'new_message', {
        message: @message.to_json
      })
    end

    respond_to do |format|
      if @message.save
        format.html { render :show, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :company_id, :conversation_id, :sender_id)
    end
end