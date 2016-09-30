# secret_handshake.rb

# 1. The initialize method of the class should take one argument
#   * The argument can be either an integer or a string
#   * If the argument is an integer it should be convert to a string representing the
#   binary value of that integer
#   * If the argument is a string it should be validated to ensure that it is a validated
#   binary number - if invalid the number '00000000' should be assigned
#   * We are only interested in the last five digits of the binary number
# 2. The class requires a `commands` instance method
#   * `commands` should return an array of strings equivalent to each operation
#   * Iterate through the binary number and run the operations in the appropriate order

class SecretHandshake
  attr_reader :commands

  def initialize(input)
    @input = input
    @binary_chars = parse_input.chars
    @commands = []
    wink
    double_blink
    close_your_eyes
    jump
    reverse
  end

  def parse_input
    if @input.class == Fixnum
      @input.to_s(2)
    elsif @input.class == String
      validate_input
    else
      '0'
    end
  end

  def validate_input
    @input =~ /[01]/ ? @input : '0'
  end

  def wink
    @commands << 'wink' if @binary_chars.pop == '1'
  end

  def double_blink
    @commands << 'double blink' if @binary_chars.pop == '1'
  end

  def close_your_eyes
    @commands << 'close your eyes' if @binary_chars.pop == '1'
  end

  def jump
    @commands << 'jump' if @binary_chars.pop == '1'
  end

  def reverse
    @commands.reverse! if @binary_chars.pop == '1'
  end
end
