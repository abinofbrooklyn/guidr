class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  validates :body, presence: true
  validates :conversation_id, presence: true
  validates :user_id, presence: true

  default_scope { order(create_at: :asc) }
end
