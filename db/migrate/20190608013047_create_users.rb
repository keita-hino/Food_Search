class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.binary :encrypted_user_token
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
