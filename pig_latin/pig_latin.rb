# pig_latin.rb

# ---------RULES--------
# 1. if a word begins with a vowel, add an "ay" sound at the end of the word
# 2. if a word begins with a consonant sound, move it (all letters until the first vowel) 
# to the end and add an "ay" sound to the end of the word
# 3. if a word begins with qu then the qu are both shifted, not just the q
# 4. if a word begins with a consonant immediately followed by qu then all three are shifted
# 5. if a word beggining with x or y has a con as the second letter then it is treated the
# same as a word starting with a vowel

class PigLatin
  def self.translate(string)
    string.split(' ').map! { |word| anslatetray(word) }.join(' ')
  end

  def self.anslatetray(word)
    first_two_chars = word.chars.slice(0, 2)
    if is_x_or_y_then_consonant?(first_two_chars) || is_a_vowel?(first_two_chars.first)
      add_ay(word)
    else
      add_ay(shift_consonants(word))
    end
  end

  def self.is_x_or_y_then_consonant?(substring)
    (substring.first == 'x' || substring.first == 'y') && !is_a_vowel?(substring.last)
  end

  def self.is_a_vowel?(first_letter)
    ['a', 'e', 'i', 'o', 'u'].include?(first_letter)
  end

  def self.add_ay(string)
    string + 'ay'
  end

  def self.shift_consonants(string)
    chars = string.chars
    additional_shift = chars.slice(0, 3).join.include?('qu') ? 1 : 0
    first_vowel_index = chars.find_index { |char| is_a_vowel?(char) }
    chars.rotate(first_vowel_index + additional_shift).join
  end
end