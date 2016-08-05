# scrabble_score.rb

class Scrabble # :nodoc:
  SCORES = {
    'a' => 1, 'b' => 3, 'c' => 3, 'd' => 2, 'e' => 1, 'f' => 4,
    'g' => 2, 'h' => 4, 'i' => 1, 'j' => 8, 'k' => 5, 'l' => 1,
    'm' => 3, 'n' => 1, 'o' => 1, 'p' => 3, 'q' => 10, 'r' => 1,
    's' => 1, 't' => 1, 'u' => 1, 'v' => 4, 'w' => 4, 'x' => 8,
    'y' => 4, 'z' => 10
  }.freeze

  def initialize(word)
    @word = word
  end

  def self.score(word)
    return 0 if word.nil? || word.empty?
    word.downcase.chars.map { |letter| letter.gsub(/[a-z]/, SCORES).to_i }
        .reduce(&:+)
  end

  def score
    self.class.score(@word)
  end
end
