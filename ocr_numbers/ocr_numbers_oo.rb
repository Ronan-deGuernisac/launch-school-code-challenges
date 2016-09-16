# ocr_numbers_oo.rb

class OCR # :nodoc:
  def initialize(text)
    @text = text.split("\n")
    @rows = make_rows
  end

  def convert
    @rows.map(&:to_s).join(',')
  end

  def make_rows
    rows = []
    rows << @text.slice!(0, 4) until @text.empty?
    rows.map { |row| OcrRow.new(row) }
  end
end

class OcrRow # :nodoc:
  def initialize(row)
    @rows = row.slice(0, 3)
    @digit_rows = rows_to_digits
  end

  def rows_to_digits
    max_row_length = @rows.map(&:size).max
    @rows.map! { |row| row.ljust(max_row_length).scan(/.../) }
    @rows.transpose.map { |digit| OcrDigit.new(digit) }
  end

  def to_s
    @digit_rows.map(&:digit).join
  end
end

class OcrDigit # :nodoc:
  attr_reader :digit

  DIGIT_MAP = [
    [' _ ', '| |', '|_|'], ['   ', '  |', '  |'], [' _ ', ' _|', '|_ '],
    [' _ ', ' _|', ' _|'], ['   ', '|_|', '  |'], [' _ ', '|_ ', ' _|'],
    [' _ ', '|_ ', '|_|'], [' _ ', '  |', '  |'], [' _ ', '|_|', '|_|'],
    [' _ ', '|_|', ' _|']
  ].freeze

  def initialize(digit_string)
    @digit = DIGIT_MAP.index(digit_string) || '?'
  end
end
