class AddBiographyColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :biography, :text
  end
end
