class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :food_type
      # t.string :meals
      t.integer :user_id
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
