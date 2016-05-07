# pig_latin.rb

class PigLatin # :nodoc:
  def self.translate(string)
    string.split(' ').map { |word| anslatetray(word) }.join(' ')
  end

  def self.anslatetray(word)
    first_two_chars = word.chars.slice(0, 2)
    if x_or_y_then_consonant?(first_two_chars) || a_vowel?(first_two_chars.first)
      add_ay(word)
    else
      add_ay(shift_consonants(word))
    end
  end

  def self.x_or_y_then_consonant?(substring)
    %w(x y).include?(substring.first) && !a_vowel?(substring.last)
  end

  def self.a_vowel?(first_letter)
    %w(a e i o u).include?(first_letter)
  end

  def self.add_ay(string)
    string + 'ay'
  end

  def self.shift_consonants(string)
    chars = string.chars
    additional_shift = chars.slice(0, 3).join.include?('qu') ? 1 : 0
    first_vowel_index = chars.find_index { |char| a_vowel?(char) }
    chars.rotate(first_vowel_index + additional_shift).join
  end
end
