# robot_simulator.rb

# 1. Robots have three possible MOVEMENTS:
#   - TURN LEFT
#   - TURN RIGHT
#   - ADVANCE

# 2. Robot LOCATION is defined by positive or negative integer values 
# set as 'X' and 'Y' coordinates (e.g. {3, 8})

# 3. Robot DIRECTION is defined by compass points 'N', 'E', 'S', 'W'

# 4. Robots receive INSTRUCTIONS in the form of a String of letters, each letter
# corresponding to the three possible MOVEMENTS:
  
# 'R' = TURN RIGHT
# 'L' = TURN LEFT
# 'A' = ADVANCE

# 5. Example: If a robot starts ar {7, 3} facing North, instructions "RAALAL" should
# leave it at {9, 4} facing West


class Robot
  DIRECTIONS = [:north, :east, :south, :west].freeze

  attr_reader :bearing, :coordinates

  def initialize
    @bearing = nil
    @coordinates = []
  end
  
  def orient(direction)
    raise ArgumentError, 
      'Direction is invalid' unless DIRECTIONS.include?(direction)
    @bearing = direction
  end

  def turn_right
    idx = DIRECTIONS.find_index(bearing)
    @bearing = DIRECTIONS.rotate[idx]
  end

  def turn_left
    idx = DIRECTIONS.find_index(bearing)
    @bearing = DIRECTIONS.rotate(-1)[idx]
  end

  def at(*coords)
    @coordinates = coords
  end

  def advance
    case bearing
      when :north then @coordinates[1] += 1
      when :south then @coordinates[1] -= 1
      when :east then @coordinates[0] += 1
      when :west then @coordinates[0] -= 1
    end
  end
end

1. For the simulator need a Simulator class
  - Simulator class has an `instructions` instance method
    - `Simulator#instructions` takes a String as an argument and returns an Array
    of Symbols (each symbol being equivalent to the String character)
  - Simulator class has a `place` instance method which takes two arguments:
    - A Robot object
    - A Hash with three key-value pairs:
      - Integer value of the 'x' axis
      - Integer value of the 'y' axis
      - Symbol value of the direction
    - `Simulator#place` sets the corresponding ivars of the Robot object to the
      values in the hash
  - Simulator class has an `evaluate` instance method
    - `Simulator#evaluate` takes two arguments
      - A Robot object
      - A String of instructions
    - `Simulator#evaluate` parses the instructions and applies the corresponding
      actions to the Robot object


