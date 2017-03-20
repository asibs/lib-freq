class SongLink < ApplicationRecord
  belongs_to :song

  def image_path
    "song_link_icons/#{link_type}.png"
  end

  def image_exists?
    LibFreqUtils.asset_exists? "#{image_path}"
  end
end
