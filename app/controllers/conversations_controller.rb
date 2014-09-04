class ConversationsController < ApplicationController
  before_filter :require_login
  helper_method :mailbox, :conversation

  def new
    @user = User.find(params[:user_id])
  end
  
  def create
    recipient = User.find_by(email: params[:user_id])
    conversation = current_user.
      send_message(recipient, *conversation_params(:body, :subject)).conversation

    redirect_to conversation_path(conversation)
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  def index
    @conversations = Conversation.all
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end
end
