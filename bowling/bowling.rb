# bowling.rb

# 1. need to initialize a data structure to hold the scores
# 2. the roll method needs to input the rolled score at the appropriate point in the data structure
# 3. the score method needs to be able to calculate standard frames, spares, strikes and fills

# initial structure is array of 21 nil values
# use Array#bsearch_index to fill next nil
# use Array#compact to remove nils
# use Enumerable#each_slice to create array of frames
# have a frame_score, is_strike? and is_spare? helper method to calculate the cases


class Game
  def initialize
    @rolls = Array.new(21)
  end

  def roll(pins)
    @rolls[next_empty] = pins
  end

  def score
    @rolls.compact.reduce(:+)
  end

  private

  def next_empty
    @rolls.bsearch_index { |value| value.nil? }
  end
end
