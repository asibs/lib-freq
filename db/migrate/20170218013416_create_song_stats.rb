class CreateSongStats < ActiveRecord::Migration[5.0]
  def change
    create_table :song_stats do |t|
      t.references :song, index: {:unique=>true}, foreign_key: true
      t.integer :pledge_count
      t.integer :buy_count

      t.timestamps
    end
  end
end
