# simple_cipher.rb

class Cipher # :nodoc:
  ALPHABET = [*'a'..'z'].freeze
  DEFAULT_KEY = 'dddddddddddddddddddddddddddddddddddddddd'.freeze

  attr_reader :key

  def initialize(key = DEFAULT_KEY)
    check_for_errors(key)
    @key = key
  end

  def encode(string)
    cipher(string).join
  end

  def decode(string)
    cipher(string, true).join
  end

  private

  def check_for_errors(key)
    raise ArgumentError if key == ''
    raise ArgumentError if key =~ /[A-Z0-9]/
  end

  def cipher(string, reverse = false)
    string.chars.map.with_index do |character, index|
      key_letter = @key[index]
      distance_to_key_letter = ALPHABET.index(key_letter) - ALPHABET.index('a')
      distance_to_key_letter = - distance_to_key_letter if reverse
      rotated_alphabet = ALPHABET.rotate(distance_to_key_letter)
      rotated_alphabet[ALPHABET.index(character)]
    end
  end
end
