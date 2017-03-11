class SongPledge < ApplicationRecord
  belongs_to :song
  belongs_to :user


  def confirm_and_update_song_counts
    success = false

    self.with_lock do
      if !self.confirmed
        self.confirmed = true
        SongStat.increment_counter(:pledge_count, self.song.song_stat.id)
        self.save!
        success = true
      end
    end

    success
  end

end
