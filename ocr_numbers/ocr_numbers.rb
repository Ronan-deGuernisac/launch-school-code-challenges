# ocr_numbers.rb

# Text is returned in this format:
#   " _\n| |\n|_|\n" is 0
#   "\n  |\n  |\n" is 1

# Each digit 'section' takes 3 spaces in theory but depending on the number that is last in the row
# some sections may only take 2, 1 or zero spaces.

# 1. Need to split the text on new line to create three 'rows' (an array of three strings)
#   * Determine the length of each row
#   * Determine the length of the longest row
#   * Pad rows shorter than the longest row with blank spaces so that all rows are equal length (String#ljust ?)
# 2. Slice each row into groups of three (possibly using String#scan ?). this returns an array
#   * Transpose the arrays so that there is an array for each 'digit' (Array#transpose)
#   * Map each digit array to a number value (or a OCR_digit object) (use Array#& )
# 3. Join all the values to create a digit string which is returned by the OCR#convert method
#   * The string should be comma separated every three characters for digits of 1,000 or higher 

class OCR
  DIGIT_MAP = [
    [" _ ", "| |", "|_|"], ["   ", "  |", "  |"], [" _ ", " _|", "|_ "], [" _ ", " _|", " _|"],
    ["   ", "|_|", "  |"], [" _ ", "|_ ", " _|"], [" _ ", "|_ ", "|_|"], [" _ ", "  |", "  |"],
    [" _ ", "|_|", "|_|"], [" _ ", "|_|", " _|"]
  ]
  def initialize(text)
    @rows = make_rows(text)
  end

  def convert
    @rows.map { |row| rows_to_digits(row) }.flatten.join(',')
  end

  def rows_to_digits(digit_rows)
    max_row_length = digit_rows.map { |row| row.size }.max
    digit_rows.map! { |row| row.ljust(max_row_length) }
    digit_rows.map! { |row| row.scan(/.../) }
    digits = digit_rows.transpose
    digits.map { |digit| convert_digit(digit).to_s }.flatten.join
  end

  def convert_digit(digit_sections)
    DIGIT_MAP.index(digit_sections) || '?'
  end

  def make_rows(text)
    # need to split into groups of 4 then discard the 4th if it exists
    split_text = text.split("\n")
    rows = []
    while split_text.size > 0
      rows << split_text.slice!(0, 4)
    end
    rows.map { |row| row.slice(0, 3) }
  end
end