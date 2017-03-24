require 'digest/sha2'

module LibFreqUtils
  def self.validate_email?(email)
    email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end

  def self.hash_email(email)
    Digest::SHA512.base64digest(email)
  end

  def self.encrypt_email(plaintext_email)
    #TODO: proper encryption
    plaintext_email
  end

  def self.decrypt_email(crypted_email)
    #TODO: proper decryption
    crypted_email
  end

  def self.asset_exists?(path)
    # Different checks for prod vs dev
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? path
    else
      Rails.application.assets_manifest.assets[path].present?
    end
  end

  def self.significant_round(n)
    # Fun maths to round up to the next significant interval
    # Eg. 1 -> 10, 15 -> 20, 99 -> 100, 101 -> 200, etc
    # 1 - Take the log10 of n, floor it, giving how many times n is divisible by 10 (ensure it is always >= 1)
    # 2 - Add 1 to n (ensure we always go above n), and round it up using negative the no. of tens as the no. of significant figures

    tens = [Math.log10(n).floor, 1].max
    (n+1).ceil(-tens)
  end

end
