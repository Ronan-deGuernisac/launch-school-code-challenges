# bowling.rb

class Game # :nodoc:
  def initialize
    @rolls = Array.new(24)
    @frames = []
  end

  def roll(pins)
    roll_index = next_empty
    raise 'Pins must have a value from 0 to 10' unless (0..10).cover?(pins)
    raise 'Pin count exceeds pins on the lane' if
      open_rolls_over?(pins, roll_index)
    raise 'Should not be able to roll after game is over' unless
      game_in_progress?
    @rolls[roll_index] = pins
    @rolls[next_empty] = 'X' if pins == 10
  end

  def score
    raise 'Score cannot be taken until the end of the game' if game_in_progress?
    raise 'Game is not yet over, cannot score!' if game_in_progress?
    @rolls.compact.each_slice(2) { |frame| @frames << frame }
    frame_scores = @frames.map.with_index do |_, frame_index|
      frame_score(frame_index)
    end
    frame_scores.flatten.reduce(:+)
  end

  private

  def next_empty
    @rolls.bsearch_index(&:nil?)
  end

  def frame_score(frame_index)
    frame = @frames[frame_index]
    case
    when fill_balls?(frame_index)
      0
    when strike?(frame)
      strike_score(frame, frame_index)
    when spare?(frame)
      frame.reduce(:+) + @frames[frame_index + 1].first
    else
      frame.reduce(:+)
    end
  end

  def strike_score(frame, frame_index)
    [
      frame,
      @frames[frame_index + 1],
      @frames[frame_index + 2]
    ].flatten.reject { |value| value == 'X' }.slice(0, 3).reduce(:+)
  end

  def strike?(frame)
    frame.first == 10
  end

  def spare?(frame)
    frame.reduce(:+) == 10
  end

  def fill_balls?(frame_index)
    frame_index == 10 || frame_index == 11
  end

  def open_rolls_over?(pins, roll_index)
    roll_index.odd? && pins + @rolls[roll_index - 1] > 10
  end

  def game_in_progress?
    @rolls.compact.size < 20 + fill_balls
  end

  def fill_balls
    last_frame = @rolls.slice(18, 2).map(&:to_i)
    case
    when strike?(last_frame) && @rolls[20] == 10
      4
    when strike?(last_frame)
      2
    when spare?(last_frame)
      1
    else
      0
    end
  end
end
