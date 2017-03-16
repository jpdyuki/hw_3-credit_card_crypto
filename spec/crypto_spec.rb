require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require 'minitest/autorun'

all_test = [
  {
    encrypt_method: SubstitutionCipher::Caesar,
    message: 'Caesar cipher'
  },
  {
    encrypt_method: SubstitutionCipher::Permutation,
    message: 'Permutation cipher'
  },
  {
    encrypt_method: DoubleTranspositionCipher,
    message: 'Double Transposition cipher'
  }
]

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020', 'Soumya Ray', 'Visa')
    @key = 3
  end

  all_test.each do |test|
    describe 'Using ' << test[:message] do
      it 'should encrypt card information' do
        enc = test[:encrypt_method].encrypt(@cc, @key)
        enc.wont_equal @cc.to_s
        enc.wont_be_nil
      end

      it 'should decrypt text' do
        enc = test[:encrypt_method].encrypt(@cc, @key)
        dec = test[:encrypt_method].decrypt(enc, @key)
        dec.must_equal @cc.to_s
      end
    end
  end
end
