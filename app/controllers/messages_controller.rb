class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create message_params
    json = @message.body.to_s
    @message.save
    redirect_to @message
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:body, :sender_id, :recipient_id, :conversation_id)
    end
end
