class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
  end

  def show
    @conversation = Conversation.find(params[:id])
    @unread_messages = @conversation.messages.where(:recipient_id => current_user.id.to_s)
    @unread_messages.each do |unread|
      unread.read = true
      unread.save!
    end
    @other_user = User.find(@conversation.recipient_id)
    @message = Message.new
    @messages = @conversation.messages.order("created_at DESC").first(20)
  end

  def new
    @previous_conversation = Conversation.where(sender_id: current_user.id, recipient_id: params[:recipient_id])
    @previous_received = Conversation.where(recipient_id: current_user.id, sender_id: params[:recipient_id])
      if @previous_conversation.count > 0
        redirect_to @previous_conversation.last
      elsif @previous_received.count > 0
        redirect_to @previous_received.last
      else
      @conversation = Conversation.new
      @conversation.sender_id = current_user.id
      @conversation.recipient_id = params[:recipient_id]
      @conversation.save
      redirect_to @conversation, format: 'js'
    end
  end

  private
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    def conversation_params
      params.require(:conversation).permit(:sender_id, :recipient_id)
    end
end
