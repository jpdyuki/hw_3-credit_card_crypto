require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'
require 'base64'

all_test = [
  {
    encrypt_method: SubstitutionCipher::Caesar,
    message: 'Caesar cipher',
    key: Random.rand(100)
  },
  {
    encrypt_method: SubstitutionCipher::Permutation,
    message: 'Permutation cipher',
    key: Random.rand(100)
  },
  {
    encrypt_method: DoubleTranspositionCipher,
    message: 'Double Transposition cipher',
    key: Random.rand(100)
  },
  {
    encrypt_method: ModernSymmetricCipher,
    message: 'Modern Symmetric cipher',
    key: ModernSymmetricCipher.generate_new_key
  }
]

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new(
      '4916603231464963', 'Mar-30-2020', 'Soumya Ray', 'Visa'
    )
    @key = 3
  end

  all_test.each do |test|
    describe 'Using ' << test[:message] do
      it 'should encrypt card information' do
        enc = test[:encrypt_method].encrypt(@cc, test[:key])
        enc.wont_equal @cc.to_s
        enc.wont_be_nil
      end

      it 'should decrypt text' do
        enc = test[:encrypt_method].encrypt(@cc, test[:key])
        dec = test[:encrypt_method].decrypt(enc, test[:key])
        dec.must_equal @cc.to_s
      end
    end
  end
end

describe 'Test modern symmetric cipher' do
  before do
    @test_round = 100_000
  end
  describe 'Test key generator' do
    before do
      @b64_regex = %r/^([A-Za-z0-9\+\/]{4})*([A-Za-z0-9\+\/]{4}|[A-Za-z0-9\+\/]{3}=|[A-Za-z0-9\+\/]{2}==)$/
    end
    it 'should generate new Base64 keys' do
      @test_round.times do
        key = ModernSymmetricCipher.generate_new_key
        @b64_regex.match(key).wont_equal nil
      end
    end
    it 'should generate different keys each time' do
      keys = []
      @test_round.times { keys << ModernSymmetricCipher.generate_new_key }
      keys.size.must_equal keys.uniq.size
    end
  end
  describe 'Test robustness' do
    it 'should not replay the same encryption twice' do
      key = ModernSymmetricCipher.generate_new_key
      plain_text = Array.new(20) { Random.rand(256).chr }.join
      encrypted_msgs = []
      @test_round.times do
        encrypted_msgs << ModernSymmetricCipher.encrypt(plain_text, key)
      end
      encrypted_msgs.size.must_equal encrypted_msgs.uniq.size
    end
  end
end
