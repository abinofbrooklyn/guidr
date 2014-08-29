class ConversationMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  validates :user_id,
    uniqueness: { scope: :conversation_id }
end
