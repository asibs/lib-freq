class Song < ApplicationRecord
  belongs_to :campaign

  has_one :song_stat

  has_many :song_link
end
