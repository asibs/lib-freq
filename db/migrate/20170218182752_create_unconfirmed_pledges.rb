class CreateUnconfirmedPledges < ActiveRecord::Migration[5.0]
  # def change
  #   create_table :unconfirmed_pledges do |t|
  #     t.string :pledge_uuid
  #     t.references :user, foreign_key: true
  #     t.references :song, foreign_key: true

  #     t.timestamps
  #   end
  #   add_index :unconfirmed_pledges, :pledge_uuid
  #   add_index :song_pledges, [:user_id, :song_id], unique: true
  # end
end
