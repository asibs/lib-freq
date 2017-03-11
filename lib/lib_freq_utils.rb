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
end
