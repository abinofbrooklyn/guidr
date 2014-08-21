class CreateAvailableDates < ActiveRecord::Migration
  def change
    create_table :available_dates do |t|
      t.belongs_to :listing, index: true, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
