# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    sum = 0
    nums_a.reverse_each.with_index do |value, index|
      value *= index.odd? ? 2 : 1
      sum += value.to_s.chars.map(&:to_i).reduce(:+)
    end
    (sum % 10).zero?
  end
end
