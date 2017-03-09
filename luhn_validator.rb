module LuhnValidator
  LUHN_MAPPING = [0, 2, 4, 6, 8, 1, 3, 5, 7, 9].freeze
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    w_sum = nums_a[0..-2].reverse_each.map.with_index { |d, i|
      i.even? ? LUHN_MAPPING[d] : d
    }.reduce(&:+)
    -w_sum % 10 == nums_a[-1] % 10
  end
end
