require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963', exp: 'Mar-30-2020', name: 'Soumya Ray', net: 'Visa' },
  { num: '6011580789725897', exp: 'Sep-30-2020', name: 'Nick Danks', net: 'Visa' },
  { num: '5423661657234057', exp: 'Feb-30-2020', name: 'Lee Chen', net: 'Mastercard' }
]

cards = card_details.map { |c| CreditCard.new(c[:num], c[:exp], c[:name], c[:net]) }

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    it 'should generate the same hash on one card' do
      cards.each do |c|
        hash_first_time = c.hash
        hash_repeatedly = c.hash
        Random.rand(50).times { hash_repeatedly = c.hash }
        hash_repeatedly.must_equal hash_first_time
      end
    end

    it 'should generate different hashes for different cards' do
      hashes = cards.map(&:hash)
      hashes.size.must_equal hashes.uniq.size
    end
  end

  describe 'Test cryptographic hashing' do
    it 'should generate the same hash on one card' do
      cards.each do |c|
        hash_first_time = c.hash_secure
        hash_repeatedly = c.hash_secure
        Random.rand(50).times { hash_repeatedly = c.hash_secure }
        hash_repeatedly.must_equal hash_first_time
      end
    end

    it 'should generate different hashes for different cards' do
      hashes = cards.map(&:hash_secure)
      hashes.size.must_equal hashes.uniq.size
    end

    it 'should not be the same as regular hash' do
      cards.each do |c|
        c.hash_secure.wont_equal c.hash
      end
    end
  end
end
