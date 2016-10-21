# wordy.rb
require 'pry'
# - WordProblem class takes a string as an argument to initialize method
#   - The string comprises of:
#     - Integers in String format `'1'`, `'2'`, etc..
#     - Operations words in String format `'plus'`, `'minus'`, `'multiplied by'`, `'divided by'`
#       - Operations such as `'cubed'` are not valid
#     - A string should have at least two numbers and one valid operation to be a valid WordProblem
#       - An invalid WordProblem should return an ArgumentError
#     - Operations are carried out sequentially (i.e. normal operation order is not respected)
# - WordProblem class has a `answer` instance method which returns an integer value of the answer

# - Need to replace the number strings in the string with integers and the 
# operations strings with operations


class WordProblem # :nodoc:
  OPERATIONS = {
    'plus' => '+',
    'minus' => '-',
    'multiplied' => '*',
    'divided' => '/'
  }

  def initialize(question)
    @question = question
    @maths_problem = convert_words_to_maths.compact
    raise ArgumentError unless maths_problem_valid?
  end

  def answer
    total = @maths_problem.shift
    until @maths_problem.empty?
      total = total.send @maths_problem.shift, @maths_problem.shift
    end
    total
  end

  private

  def convert_words_to_maths
    @question.split.map do |word|
      if OPERATIONS.keys.include?(word)
        OPERATIONS[word]
      elsif word =~ /\d/
        word.to_i
      else
        nil 
      end 
    end
  end

  def maths_problem_valid?
    @maths_problem.size >= 3 && 
    @maths_problem.select.with_index { |item, index| index.even? }.all? { |item| item.is_a? Integer } &&
    @maths_problem.select.with_index { |item, index| index.odd? }.all? { |item| OPERATIONS.values.include?(item) }
  end

end
