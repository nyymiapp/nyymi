class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy, :set_read]

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
  end

  def set_read
    @messages = @conversation.messages
    @messages.reverse_each do |m|
      if not m.seen and m.sender_id != current_user.id
        m.seen = true
        m.save!
      else 
        break
      end
    end
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      puts Conversation.find(params[:id])
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:user_id, :company_id)
    end
end
