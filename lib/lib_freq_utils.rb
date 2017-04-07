require 'digest/sha2'

module LibFreqUtils

  def self.validate_email?(email)
    email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end

  def self.hash_email(email)
    # On the offchance someone has reverse-lookup hash tables of emails, repeat the email before hashing
    Digest::SHA512.base64digest(email + email)
  end

  def self.get_encryption_key
    # Two halves of the base64 encoded key are stored separately,
    # one half in the codebase (NOT CHECKED IN!), the other in the environment
    Base64.decode64(Rails.application.secrets.code_encryption_key + Rails.application.secrets.env_encryption_key)
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

    tens = [Math.log10(n), 1].max.floor
    (n+1).ceil(-tens)
  end

end
