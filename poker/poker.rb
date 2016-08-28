# poker.rb

class Poker # :nodoc:
  def initialize(hands)
    @hands = hands.map { |hand| PokerHand.new(hand) }
  end

  def best_hand
    best_score = @hands.map(&:score).max
    @hands.select { |hand| hand.score == best_score }.map(&:to_a)
  end
end

class PokerHand # :nodoc:
  def initialize(hand)
    @cards = hand.map { |card| Card.new(card) }
    @groups = group_and_sort
    @group_sizes = @groups.map(&:size)
  end

  def score
    [rank, ordered_values]
  end

  def group_and_sort
    @cards.map(&:value).sort.group_by { |card_value| card_value }
          .sort_by { |group_value, group| group.count(group_value) }
          .to_h.values.reverse
  end

  def ordered_values
    return [5, 4, 3, 2, 1] if ace_low_straight?
    @groups.flatten
  end

  def rank
    case
    when straight_flush? then 9
    when quads? then 8
    when full_house? then 7
    when flush? then 6
    when straight? then 5
    when trips? then 4
    when two_pair? then 3
    when pair? then 2
    else 1
    end
  end

  def ace_low_straight?
    @cards.map(&:value).reduce(&:+) == 28
  end

  def straight_flush?
    straight? && flush?
  end

  def quads?
    @group_sizes == [4, 1]
  end

  def full_house?
    @group_sizes == [3, 2]
  end

  def flush?
    @cards.map(&:suit).uniq.size == 1
  end

  def straight?
    @group_sizes.size == 5 && ordered_values.minmax.reduce(&:-) == -4
  end

  def trips?
    @group_sizes == [3, 1, 1]
  end

  def two_pair?
    @group_sizes == [2, 2, 1]
  end

  def pair?
    @group_sizes == [2, 1, 1, 1]
  end

  def to_a
    @cards.map(&:card)
  end
end

class Card # :nodoc:
  VALUES = {
    '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8,
    '9' => 9, 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14
  }.freeze

  attr_reader :card

  def initialize(card)
    @card = card
  end

  def value
    @card.chars.first.gsub(/[2-9TJQKA]/, VALUES).to_i
  end

  def suit
    @card.chars.last
  end
end
