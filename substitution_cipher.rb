require './credit_card.rb'
#
module SubstitutionCipher
  #
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
    end
  end
  #
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: CreditCard
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      table = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars.map { |ch| table[ch.ord].chr }.join('')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      table = (0..127).to_a.shuffle(random: Random.new(key))
      table2 = Array.new(128)
      # prestore inverse table1 into table2 to speed up
      table.each.with_index { |x, i| table2[x] = i }
      document.chars.map { |ch| table2[ch.ord].chr }.join('')
    end
  end
end
