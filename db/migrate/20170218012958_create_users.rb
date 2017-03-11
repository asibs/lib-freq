class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uuid
      t.string :hashed_email
      t.text :crypted_email, limit: 1024

      t.timestamps
    end
    add_index :users, :uuid, unique: true
    add_index :users, :hashed_email, unique: true
  end
end
