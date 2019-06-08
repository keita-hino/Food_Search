class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :open_info
      t.decimal :latitude
      t.decimal :longitude
      t.text :url
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
