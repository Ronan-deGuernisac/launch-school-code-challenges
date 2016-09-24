# reverse_odds.rb

# Problem Requirements:

# Consider a character set consisting of letters, a space, and a point.
# Words consist of one or more, but at most20 letters.
# An input text consists of one or more words separated from each other by one or more spaces and terminated by 0 or more spaces followed by a point.
# The output text is to be produced such that successive words are separated by a single space with the last word being terminated by a single point.
# Odd words are copied in reverse order while even words are merely echoed. For example, the input string:

# "whats the matter with kansas." becomes "whats eht matter htiw kansas."

# 1. Need to take a string as input
#   - get rid of excess spaces
# 2. Need to split the string into characters
# 3. Need to iterate through the collection of characters
#   - For each char push to a new string
#   - If a space is pushed, reverse the new string
  
class ReverseOdds
  attr_reader :new_string
  
  def initialize(string)
    @characters = string.split.join(' ').chars
    @new_string = ''
    write_new_string
  end
  
  def write_new_string
    indicator = 0
    temp_string = ''
    @characters.each do |character|
       temp_string << character unless character == ' '
       if separator?(character)
         temp_string.reverse! if indicator.odd?
         @new_string << temp_string
         @new_string << ' ' unless end_point(character)
         indicator += 1
         temp_string = ''
       end
    end
  end
  
  def separator?(character)
    character == ' ' || character == '.' || character == '0'
  end
  
  def end_point(character)
    character == '.' || character == '0'
  end
end

str = "whats the matter with kansas."

p ReverseOdds.new(str).new_string
