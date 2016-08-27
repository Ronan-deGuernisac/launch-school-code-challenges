# poker.rb
require 'pry'
# Need to rank the hands (high card, pair, two pair, etc..)
#   Conditions for ranking (based on suits and/ or values)
#     Straight Flush = 5 identical suits + values consecutive
#     Four of a kind = 4 identical values
#     Full house = 3 identical values + 2 identical values
#     Flush = 5 identical suits
#     Straight = values consecutive
#     Three of a Kind = 3 identical values
#     Two pair = 2 x 2 identical values
#     Pair = 2 identical values
#     High card = no other conditions met

# In the event of hands of equal rank need to identify best hand of that rank
#   Values of cards in each hand of the same rank are compared in order
#   until one hand
#   is found to have a card of higher value than another hand. If all cards are
#   of equal value
#   then the round is tied (split pot)- both hands should be returned

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
    ordered_hands = ranked_hands.map(&:comparison_order)

    hands_ranked_by_card_values = nil
    5.times do
      hands_ranked_by_card_values = []
      compare_cards(ordered_hands, hands_ranked_by_card_values, ranked_hands)
      break if hands_ranked_by_card_values.size == 1
    end
    hands_ranked_by_card_values
  end

  def compare_cards(ordered_hands, hands_ranked_by_card_values, ranked_hands)
    comparison_cards = {}
    ordered_hands.each_with_index do |hand, index|
      comparison_cards[index] = hand.last
      hand.rotate!
    end
    highest_value = comparison_cards
                    .map { |_, card_value| card_value.value }.max
    comparison_cards
      .reject! { |_, card_value| card_value.value < highest_value }
    comparison_cards.keys.each do |hand_index|
      hands_ranked_by_card_values << ranked_hands[hand_index]
    end
  end
end

class PokerHand # :nodoc:
  attr_reader :cards, :comparison_order

  def initialize(hand)
    @cards = []
    hand.each { |card| @cards << Card.new(card) }
    @hand_values = @cards.map(&:value)
    @hand_suits = @cards.map(&:suit)
    @comparison_order = order_cards
  end

  def order_cards
    ordered_cards = @cards.sort_by(&:value)
    if quads? && ordered_cards.first.value != ordered_cards.last.value
      ordered_cards.rotate!
    elsif full_house? && ordered_cards.first.value != ordered_cards.last.value
      ordered_cards.rotate!(2)
    end
    ordered_cards
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
