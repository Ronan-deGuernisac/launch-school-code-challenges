# bowling.rb

class Game # :nodoc:
  def initialize
    @rolls = []
    @frames = []
  end

  def roll(pins)
    validate_roll_value(pins)
    validate_frame_value(pins)
    validate_game_status

    @rolls << pins
    @rolls << 'X' if pins == 10
  end

  def score
    validate_standard_balls
    validate_fill_balls

    @rolls.compact.each_slice(2) { |frame| @frames << frame }
    @frames.each_with_index.reduce(0) do |sum, (_, frame_index)|
      sum + frame_score(frame_index)
    end
  end

  private

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
    !strike?(frame) && frame.reduce(:+) == 10
  end

  def fill_balls?(frame_index)
    frame_index == 10 || frame_index == 11
  end

  def open_rolls_over?(pins)
    roll_index = @rolls.size
    roll_index.odd? && pins + @rolls[roll_index - 1] > 10
  end

  def game_in_progress?
    standard_balls_not_played? || fill_balls_not_played?
  end

  def standard_balls_not_played?
    @rolls.size < 20
  end

  def fill_balls_not_played?
    standard_balls_not_played? || @rolls.size < 20 + fill_balls_spaces
  end

  def fill_balls_spaces
    last_frame = @rolls.slice(18, 2)
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

  def validate_roll_value(pins)
    raise 'Pins must have a value from 0 to 10' unless (0..10).cover?(pins)
  end

  def validate_frame_value(pins)
    raise 'Pin count exceeds pins on the lane' if
      open_rolls_over?(pins)
  end

  def validate_game_status
    raise 'Should not be able to roll after game is over' unless
      game_in_progress?
  end

  def validate_standard_balls
    raise 'Score cannot be taken until the end of the game' if
      standard_balls_not_played?
  end

  def validate_fill_balls
    raise 'Game is not yet over, cannot score!' if fill_balls_not_played?
  end
end
