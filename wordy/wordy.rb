# wordy.rb

class WordProblem # :nodoc:
  OPERATIONS = {
    'plus' => '+',
    'minus' => '-',
    'multiplied' => '*',
    'divided' => '/'
  }.freeze

  def initialize(question)
    @question = question
    @maths_problem = convert_words_to_maths.compact
    raise ArgumentError unless maths_problem_valid?
  end

  def answer
    total = next_element
    loop do
      total = total.send(next_element, next_element)
      break if @maths_problem.empty?
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
      end
    end
    # maps to nil if no condition matched
  end

  def next_element
    @maths_problem.shift
  end

  def maths_problem_valid?
    sufficient_length? && even_items_integers? && odd_items_operations?
  end

  def sufficient_length?
    @maths_problem.size >= 3
  end

  def even_items_integers?
    even_items.all? { |item| item.is_a? Integer }
  end

  def odd_items_operations?
    odd_items.all? { |item| OPERATIONS.values.include?(item) }
  end

  def even_items
    @maths_problem.select.with_index { |_, index| index.even? }
  end

  def odd_items
    @maths_problem.select.with_index { |_, index| index.odd? }
  end
end
