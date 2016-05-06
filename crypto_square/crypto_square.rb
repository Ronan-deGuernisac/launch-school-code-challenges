# crypto_square.rb

require 'pry'

class Crypto
  def initialize(string)
    @string = string
  end

  def normalize_plaintext
    square.join
  end

  def size
    square_cols
  end

  def plaintext_segments
    square.map(&:join)
  end

  def ciphertext
    cipher.join
  end

  def normalize_ciphertext
    cipher.map(&:join).join(' ')
  end

  private

  def cleaned_string
    @string.chars.keep_if { |char| /[0-9a-zA-Z]/ =~ char }.map(&:downcase)
  end

  def string_length
    cleaned_string.size
  end

  def square_cols
    Math.sqrt(string_length).ceil
  end

  def square_rows
    square.size
  end

  def square_area
    square_cols * square_rows
  end

  def long_cols
    square_cols - short_cols
  end

  def short_cols
    square_area - string_length
  end

  def square
    characters = cleaned_string
    square = []
    square_cols.times { square << characters.slice!(0, square_cols) }
    square.reject { |segment| segment.empty? }
  end

  def cipher
    square_copy = square
    cipher_characters = []
    square_cols.times do
      square_copy.each { |row| cipher_characters << row.shift if !row.empty? }
    end
    cipher_square = []
    long_cols.times { cipher_square << cipher_characters.slice!(0, square_rows) }
    short_cols.times { cipher_square << cipher_characters.slice!(0, square_rows - 1) }
    cipher_square.reject { |segment| segment.empty? }
  end
end
