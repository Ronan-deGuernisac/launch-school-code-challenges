# rail_fence_cipher.rb

class RailFenceCipher # :nodoc:
  attr_accessor :characters, :rails
  attr_reader :rail_order

  def initialize(text, rail_count)
    @characters = text.chars
    @rails = Array.new(rail_count) { [] }
    @rail_order = set_rail_order(text, rail_count)
  end

  def self.encode(text, rail_count)
    cipher = new(text, rail_count)

    cipher.rail_order.each do |rail_number|
      cipher.rails[rail_number - 1] << cipher.characters.shift
    end
    cipher.rails.flatten.join
  end

  def self.decode(text, rail_count)
    cipher = new(text, rail_count)
    cipher.fill_rails

    deciphered_text = ''
    cipher.rail_order.each do |rail_number|
      deciphered_text << cipher.rails[rail_number - 1].shift
    end
    deciphered_text
  end

  def fill_rails
    @rails.each_index do |index|
      rail_spaces = @rail_order.count(index + 1)
      count = 0
      
      while count < rail_spaces
        @rails[index] << @characters.shift
        count += 1
      end
    end
  end

  private

  def set_rail_order(text, rail_count)
    zigzags = [*1...rail_count] + [*1..rail_count].reverse
    zigzags.pop unless rail_count == 1
    zigzag_amount = (text.length / rail_count.to_f).ceil
    order = []

    zigzag_amount.times do
      order << zigzags
    end
    order.flatten.slice(0, text.length)
  end
end
