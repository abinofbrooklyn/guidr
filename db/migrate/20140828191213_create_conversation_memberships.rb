class CreateConversationMemberships < ActiveRecord::Migration
  def change
    create_table :conversation_memberships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :conversation, index: true
    end
  end
end
