# robot_simulator.rb

class Robot # :nodoc:
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

class Simulator # :nodoc:
  INSTRUCTIONS_MAP = {
    'L' => :turn_left,
    'R' => :turn_right,
    'A' => :advance
  }.freeze

  def instructions(instruction_list)
    instruction_list.chars.map do |instruction|
      INSTRUCTIONS_MAP[instruction]
    end
  end

  def place(robot, robot_data)
    robot.at(robot_data[:x], robot_data[:y])
    robot.orient(robot_data[:direction])
  end

  def evaluate(robot, instruction_list)
    instructions(instruction_list).each do |instruction|
      instruct_robot(robot, instruction)
    end
  end

  private

  def instruct_robot(robot, instruction)
    case instruction
    when :turn_left then robot.turn_left
    when :turn_right then robot.turn_right
    when :advance then robot.advance
    end
  end
end
