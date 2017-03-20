class Song < ApplicationRecord
  belongs_to :campaign
  has_one :song_stat
  has_many :song_link

  after_create :create_song_stats_record

  def create_song_stats_record
    self.create_song_stat(pledge_count: 0, buy_count: 0)
  end

  def find_link(type)
    song_link.to_a.find { |link| link.link_type == type }
  end
end
