class StaticPagesController < ApplicationController
  def home
    @users = User.all
    @message = Message.new
    @conversation = Conversation.new
    if user_signed_in?
      @messages = Message.where(:recipient_id => current_user.id, :read => false)
    end
  end
end
