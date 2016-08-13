# diamond.rb

class Diamond #:nodoc:
  def self.make_diamond(middle_letter)
    diamond = [*'A'..middle_letter] + [*'A'...middle_letter].reverse

    diamond.map { |letter| create_section(letter, diamond.size) }.join
  end

  class << self
    private

    def create_section(letter, width)
      inner_padding = (letter.ord - 65) * 2
      section = letter.ljust(inner_padding)

      return section.center(width) + "\n" if inner_padding == 0
      (section + letter).center(width) + "\n"
    end
  end
end
