# robot_name.rb

class Robot # :nodoc:
  @@robot_names = []

  attr_reader :name

  def initialize
    @name = generate_name
    @@robot_names << @name
  end

  def generate_name
    name = ''
    loop do
      name = [*'AA'..'ZZ'].sample.concat([*'000'..'999'].sample)
      break unless @@robot_names.include?(name)
    end
    name
  end

  def reset
    @@robot_names.delete(@name)
    @name = generate_name
    @@robot_names << @name
  end
end
