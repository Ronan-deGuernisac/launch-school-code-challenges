# simple_cipher.rb

class Cipher # :nodoc:
  ALPHABET = [*'a'..'z'].freeze

  attr_reader :key

  def initialize(key = generate_key)
    raise ArgumentError if key =~ /[A-Z0-9]/ || key == ''
    @key = key
  end

  def encode(string)
    cipher(string).join
  end

  def decode(string)
    cipher(string, true).join
  end

  private

  def cipher(string, reverse = false)
    string.chars.map.with_index do |character, index|
      key_letter = @key[index]
      distance_to_key_letter = ALPHABET.index(key_letter) - ALPHABET.index('a')
      distance_to_key_letter = - distance_to_key_letter if reverse
      ALPHABET.rotate(distance_to_key_letter)[ALPHABET.index(character)]
    end
  end

  def generate_key
    (1..100).map { ALPHABET[rand(25)] }.join
  end
end
