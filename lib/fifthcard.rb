require_relative "fifthcard/version"
require 'deck'

module Fifthcard
  def self.encode(hand)
    by_suit = hand.group_by(&:suit)
    big_suit, suited_cards = by_suit.find{|suit, cards| cards.size > 1}
    base_card, target_card = suited_cards.sort.each_cons(2).find do |low, high|
      high.to_i - low.to_i <= 6
    end
    counting_cards = sort_cards(hand.cards - [target_card, base_card])
    diff = target_card.to_i - base_card.to_i
    Hand.new.tap do |encoding|
      [base_card, *counting_cards.permutation.to_a[diff - 1]].each do |card|
        encoding << card
      end
    end
  end

  def self.decode(hand)
    base_card = hand.cards.first
    counting_cards = hand.cards[1..-1]
    diff = sort_cards(counting_cards).permutation.to_a.index(counting_cards) + 1
    base_card + diff
  end

  def self.sort_cards(cards)
    cards.sort_by {|card| [card.to_i, card.suit] }
  end
end
