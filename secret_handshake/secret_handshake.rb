# secret_handshake.rb

class SecretHandshake
  COMMANDS = ['wink', 'double blink', 'close your eyes', 'jump']

  attr_reader :commands

  def initialize(input)
    @input = input
    @binary_chars = parse_input.chars
    @commands = []
    run_commands
    reverse
  end

  private

  def parse_input
    if @input.class == Fixnum
      @input.to_s(2)
    elsif @input =~ /[01]/
      @input
    else
      '0'
    end
  end

  def run_commands
    COMMANDS.each do |command|
      @commands << command if char_is_1?
    end
  end

  def reverse
    @commands.reverse! if char_is_1?
  end

  def char_is_1?
    @binary_chars.pop == '1'
  end
end
