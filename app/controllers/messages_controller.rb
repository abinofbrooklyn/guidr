require 'GuidrMessage'

class MessagesController < ApplicationController
  def create 
    @conversation = current_user.conversation.find(params[conversation_id])
    @message = Message.new(message_params)
    @message.conversation = @conversation

    current_user.messages << @message

    MessageSend.new(@message).send
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
