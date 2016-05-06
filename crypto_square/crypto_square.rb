# crypto_square.rb

class Crypto # :nodoc:
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

  def square_cols
    Math.sqrt(cleaned_string.size).ceil
  end

  def square_rows
    (cleaned_string.size.to_f / square_cols).ceil
  end

  def short_rows
    square_cols * square_rows % cleaned_string.size == 0 ? 0 : 1
  end

  def long_rows
    square_rows - short_rows
  end

  def short_cols
    square_cols * square_rows - cleaned_string.size
  end

  def long_cols
    square_cols - short_cols
  end

  def squarify(characters, first_iterator, second_iterator, first_limiter, second_limiter)
    square = []
    first_iterator.times { square << characters.slice!(0, first_limiter) }
    second_iterator.times { square << characters.slice!(0, second_limiter) }
    square
  end

  def cipherify
    square_copy = square
    characters = []
    square_cols.times do
      square_copy.each { |row| characters << row.shift unless row.empty? }
    end
    characters
  end

  def square
    squarify(cleaned_string, long_rows, short_rows, square_cols, square_cols - short_cols)
  end

  def cipher
    squarify(cipherify, long_cols, short_cols, square_rows, square_rows - short_rows)
  end
end
