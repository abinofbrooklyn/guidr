class ConversationsController < ApplicationController

  def new
    @listing = find_listing
    @conversation = Conversation.new
  end

  def create
    @conversation = current_user.conversations.new(conversation_params)

    if @conversation.save
      redirect_to @conversation
    else
      render :new
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end
  
  def index
    @conversations = current_user.conversations
  end

  private

  def find_listing
    Listing.find(params[:listing_id])
  end

  def conversation_params
    params.require(:conversation).permit(:title)
  end
end
