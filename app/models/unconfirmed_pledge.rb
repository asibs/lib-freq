class UnconfirmedPledge < ApplicationRecord
  belongs_to :user
  belongs_to :song


  def self.upsert(user_id, song_id, pledge_uuid)
    begin
      pledge = UnconfirmedPledge.find_or_create_by( {user_id: user_id, song_id: song_id} )
      pledge.pledge_uuid = pledge_uuid
      pledge.save
    rescue ActiveRecord::RecordNotUnique
      retry
    end
    pledge
  end
  
end
