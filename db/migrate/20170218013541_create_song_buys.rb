class CreateSongBuys < ActiveRecord::Migration[5.0]
  def change
    create_table :song_buys do |t|
      t.references :song, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :song_buys, [:user_id, :song_id], unique: true
  end
end
