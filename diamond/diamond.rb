# diamond.rb

class Diamond #:nodoc:
  def self.make_diamond(transverse_letter)
    diamond = [*'A'..transverse_letter] + [*'A'...transverse_letter].reverse
    diamond.map { |letter| add_inner_padding(letter) }
      .map { |section| add_outer_padding(section ,transverse_letter) }
      .join("\n") + "\n"
  end

  def self.add_inner_padding(letter)
    padding = (letter.ord - 65) * 2
    return letter if padding == 0
    letter.ljust(padding) + letter
  end

  def self.add_outer_padding(section, transverse_letter)
    width = (transverse_letter.ord - 65) * 2 + 1
    section.center(width)
  end
end
