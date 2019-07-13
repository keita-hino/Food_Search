class CreateTemps < ActiveRecord::Migration[5.2]
  def change
    create_table :temps do |t|
      t.text :userid
      t.jsonb :payload
      
      t.timestamps
    end
  end
end
