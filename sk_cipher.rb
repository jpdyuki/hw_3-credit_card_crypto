require 'rbnacl/libsodium'
require 'base64'

# Usage:
# Step1)  key = ModernSymmetricCipher.generate_new_key
# Step2)  cipher = ModernSymmetricCipher.encrypt(doc,key)
# Result) assert(doc == ModernSymmetricCipher.decrypt(cipher,key))
module ModernSymmetricCipher
  def self.generate_new_key
    # DO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.encode64(key)
  end

  def self.encrypt(document, key)
    # DO: Return an encrypted string
    #     Use base64 for ciphertext so that it is sendable as text
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.decode64(key))
    Base64.encode64(simple_box.encrypt(document))
  end

  def self.decrypt(aes_crypt, key)
    # DO: Decrypt from encrypted message above
    #     Expect Base64 encrypted message and Base64 key
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.decode64(key))
    simple_box.decrypt(Base64.decode64(aes_crypt))
  end
end
