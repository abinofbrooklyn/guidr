class CreateReservation < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :listing, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
