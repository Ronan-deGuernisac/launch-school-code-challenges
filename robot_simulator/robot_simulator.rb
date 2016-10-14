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