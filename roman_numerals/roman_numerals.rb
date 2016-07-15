# roman_numerals.rb

class Fixnum # :nodoc:
  def to_roman
    number = self

    hundreds_numerals = %w(C CC CCC CD D DC DCC DCCC CM)
    tens_numerals = %w(X XX XXX XL L LX LXX LXXX XC)
    ones_numerals = %w(I II III IV V VI VII VIII IX)

    thousands = number / 1000
    hundreds = number % 1000 / 100
    tens = number % 1000 % 100 / 10
    ones = number % 1000 % 100 % 10

    numeral = ''

    thousands.times { numeral << 'M' }
    numeral << hundreds_numerals[hundreds - 1] if hundreds > 0
    numeral << tens_numerals[tens - 1] if tens > 0
    numeral << ones_numerals[ones - 1] if ones > 0

    numeral
  end
end
