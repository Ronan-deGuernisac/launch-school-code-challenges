# poker.rb

class Poker # :nodoc:
  def initialize(hands)
    @hands = []
    hands.each { |hand| @hands << PokerHand.new(hand) }
  end

  def best_hand
    ranked_hands = rank_by_hand
    return sanitize_output(ranked_hands) if ranked_hands.size == 1
    sanitize_output(rank_by_card(ranked_hands))
  end

  def sanitize_output(hands)
    hands.map do |hand|
      hand.cards.map(&:card_code)
    end
  end

  def rank_by_hand
    best_rank = @hands.map(&:rank).min
    @hands.reject { |hand| hand.rank != best_rank }
  end

  def rank_by_card(ranked_hands)
    max_values = ranked_hands.map(&:ordered_values).transpose.map(&:max)
    max_values.each_with_index do |value, index|
      ranked_hands.reject! { |hand| hand.ordered_values[index] != value }
      return ranked_hands if ranked_hands.size == 1
    end
    ranked_hands
  end
end

class PokerHand # :nodoc:
  attr_reader :cards, :ordered_values

  def initialize(hand)
    @cards = []
    hand.each { |card| @cards << Card.new(card) }
    @hand_values = @cards.map(&:value)
    @hand_suits = @cards.map(&:suit)
    @ordered_values = order_cards.map(&:value)
  end

  def order_cards
    @cards.sort_by(&:value).group_by(&:value)
          .sort_by do |group_value, card_group|
      card_group.map(&:value).count(group_value)
    end.to_h.values.flatten.reverse
  end

  def rank
    case
    when straight_flush? then 1
    when quads? then 2
    when full_house? then 3
    when flush? then 4
    when straight? then 5
    when trips? then 6
    when two_pair? then 7
    when pair? then 8
    else 9
    end
  end

  def straight_flush?
    straight? && flush?
  end

  def quads?
    count_values.sort == [1, 4]
  end

  def full_house?
    count_values.sort == [2, 3]
  end

  def flush?
    @hand_suits.uniq.size == 1
  end

  def straight?
    sorted_vals = @hand_values.sort.join
    ace_to_five_straight?(sorted_vals) || [*2..14].join.include?(sorted_vals)
  end

  def trips?
    count_values.sort == [1, 1, 3]
  end

  def two_pair?
    count_values.sort == [1, 2, 2]
  end

  def pair?
    count_values.sort == [1, 1, 1, 2]
  end

  def count_values
    @hand_values.uniq.map { |value| @hand_values.count(value) }
  end

  def ace_to_five_straight?(string)
    string == '234514'
  end
end

class Card # :nodoc:
  CARD_VALUES = {
    '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8,
    '9' => 9, 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14
  }.freeze

  attr_reader :card_code, :value, :suit

  def initialize(card)
    @card_code = card
  end

  def value
    @card_code.chars.first.gsub(/[2-9TJQKA]/, CARD_VALUES).to_i
  end

  def suit
    @card_code.chars.last
  end
end
