# word_count.rb

class Phrase # :nodoc:
  def initialize(sentence)
    @sentence = sentence
  end

  def word_count
    words = @sentence.downcase.tr(',', ' ').delete('^0-9a-z\' ').split
    words.map! { |word| word.start_with?("'") ? remove_quotes(word) : word }
    words.uniq.map { |word| [word, words.count(word)] }.to_h
  end

  def remove_quotes(word)
    word = word.chars.rotate
    word.pop(2)
    word.join
  end
end
