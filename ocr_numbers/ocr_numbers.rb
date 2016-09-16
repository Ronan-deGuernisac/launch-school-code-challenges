# ocr_numbers.rb

class OCR # :nodoc:
  DIGIT_MAP = [
    [' _ ', '| |', '|_|'], ['   ', '  |', '  |'], [' _ ', ' _|', '|_ '],
    [' _ ', ' _|', ' _|'], ['   ', '|_|', '  |'], [' _ ', '|_ ', ' _|'],
    [' _ ', '|_ ', '|_|'], [' _ ', '  |', '  |'], [' _ ', '|_|', '|_|'],
    [' _ ', '|_|', ' _|']
  ].freeze
  
  def initialize(text)
    @text = text.split("\n")
    @rows = make_rows
  end

  def convert
    @rows.map { |row| rows_to_digits(row) }.flatten.join(',')
  end

  def rows_to_digits(digit_rows)
    max_row_length = digit_rows.map(&:size).max
    digit_rows.map! { |row| row.ljust(max_row_length).scan(/.../) }
    digit_rows.transpose.map { |digit| convert_digit(digit) }.flatten.join
  end

  def convert_digit(digit_sections)
    DIGIT_MAP.index(digit_sections) || '?'
  end

  def make_rows
    rows = []
    rows << @text.slice!(0, 4) until @text.empty?
    rows.map { |row| row.slice(0, 3) }
  end
end
