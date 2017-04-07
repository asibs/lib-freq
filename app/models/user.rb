require 'securerandom'

class User < ApplicationRecord
  attr_encrypted :email, key: LibFreqUtils.get_encryption_key

  has_many :song_pledge
  has_many :song_buy


  def self.find_or_create(email)
    hashed_email = LibFreqUtils.hash_email(email)

    begin
      user = User.find_or_create_by(hashed_email: hashed_email) do |u|
        u.uuid = SecureRandom.uuid
        u.email = email
      end
    rescue ActiveRecord::RecordNotUnique
      # Race condition with multiple requests could cause the create to fail
      # Just retry and the find should succeed
      retry
    end

    user
  end
end
