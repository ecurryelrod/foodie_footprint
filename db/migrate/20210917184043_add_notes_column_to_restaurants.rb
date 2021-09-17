class AddNotesColumnToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :notes, :string
  end
end
