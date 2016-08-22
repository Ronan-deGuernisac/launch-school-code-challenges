# rail_fence_cipher.rb

class RailFenceCipher
  def self.encode(string, rail_count)
    characters = string.chars
    rails = Array.new(rail_count) { Array.new }
    rail_order = set_rail_order(string, rail_count)

    rail_order.each do |rail_number|
      rails[rail_number - 1] << characters.shift
    end
    rails.flatten.join
  end

  def self.decode(string, rail_count)
    characters = string.chars
    rails = Array.new(rail_count) { Array.new }
    rail_order = set_rail_order(string, rail_count)
    rails.each_index do |index|
      rail_spaces = rail_order.count(index + 1)

      count = 0
      while count < rail_spaces
        rails[index] << characters.shift
        count += 1
      end
    end
    str = ''
    rail_order.each do |rail|
      rail_index = rail - 1
      character = rails[rail_index].shift
      str << character
    end
    str
  end

  private

  def self.set_rail_order(string, rail_count)
    string_length = string.length
    if rail_count == 1
      zigzags = [1]
    else
      zigzags = [*1...rail_count] + [*2..rail_count].reverse
    end
    zig_zag_number = (string_length / rail_count.to_f).ceil
    order = []
    zig_zag_number.times do
      order << zigzags
    end
    order.flatten.slice(0, string_length)
  end

end
