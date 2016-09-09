# simple_cipher.rb

class Cipher
  ALPHABET = [*'a'..'z'].freeze
  DEFAULT_KEY = "dddddddddddddddddddddddddddddddddddddddd".freeze

  attr_reader :key

  def initialize(key = DEFAULT_KEY)
    check_for_errors(key)
    @key = key
  end

  def encode(string)
    characters = string.chars
    characters.map.with_index do |character, index|
      key_char = @key[index]
      distance_to_key_char = ALPHABET.index(key_char) - ALPHABET.index('a')
      char_alpha_index = ALPHABET.index(character)
      rotated_alpha = ALPHABET.rotate(distance_to_key_char)
      rotated_alpha[char_alpha_index]
    end.join
  end

  def decode(string)
    characters = string.chars
    characters.map.with_index do |character, index|
      key_char = @key[index]
      distance_to_key_char = ALPHABET.index(key_char) - ALPHABET.index('a')
      char_alpha_index = ALPHABET.index(character)
      rotated_alpha = ALPHABET.rotate(- distance_to_key_char)
      rotated_alpha[char_alpha_index]
    end.join
  end

  private

  def check_for_errors(key)
    raise ArgumentError if key == ''
    raise ArgumentError if key =~ /[A-Z0-9]/
  end
end
