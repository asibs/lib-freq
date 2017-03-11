class CreateSongPledges < ActiveRecord::Migration[5.0]
  def change
    create_table :song_pledges do |t|
      t.references :user, foreign_key: true
      t.references :song, foreign_key: true
      t.boolean :confirmed

      t.timestamps
    end
    add_index :song_pledges, [:user_id, :song_id], unique: true
  end
end
