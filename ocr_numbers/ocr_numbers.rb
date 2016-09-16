# ocr_numbers.rb

Text is returned in this format:
  " _\n| |\n|_|\n" is 0
  "\n  |\n  |\n" is 1

Each digit 'section' takes 3 spaces in theory but depending on the number that is last in the row
some sections may only take 2, 1 or zero spaces.

1. Need to split the text on new line to create three 'rows' (an array of three strings)
  * Determine the length of each row
  * Determine the length of the longest row
  * Pad rows shorter than the longest row with blank spaces so that all rows are equal length (String#ljust ?)
2. Slice each row into groups of three (possibly using String#scan ?). this returns an array
  * Transpose the arrays so that there is an array for each 'digit' (Array#transpose)
  * Map each didgit array to a number value (or a OCR_didgit object)
3. Join all the values to create a digit string which is returned by the OCR#convert method
  * The string should be comma separated every three characters for digits of 1,000 or higher 