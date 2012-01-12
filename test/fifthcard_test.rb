require 'test/unit'
require './lib/fifthcard'

class FifthcardTest < Test::Unit::TestCase
  def test_encode
    hand = Hand.new
    [
      [10,     'Diamonds'],
      [6,      'Diamonds'],
      ['King', 'Diamonds'],
      [6,      'Hearts'],
      [9,      'Spades'],
    ].each {|card| hand << Card.new(*card)}
    four = Fifthcard.encode(hand)
    expected = [
      [6,      'Diamonds'],
      [9,      'Spades'],
      ['King', 'Diamonds'],
      [6,      'Hearts'],
    ].map {|card| Card.new(*card)}
    assert_equal expected, four.cards
  end

  def test_encode_with_suit_tiebreaker
    hand = Hand.new
    [
      [10,     'Diamonds'],
      [6,      'Diamonds'],
      ['King', 'Diamonds'],
      ['King', 'Hearts'],
      [9,      'Spades'],
    ].each {|card| hand << Card.new(*card)}
    four = Fifthcard.encode(hand)
    expected = [
      [6,      'Diamonds'],
      ['King', 'Diamonds'],
      ['King', 'Hearts'],
      [9,      'Spades'],
    ].map{|card| Card.new(*card)}
    assert_equal expected, four.cards
  end

  def test_decode
    hand = Hand.new
    [
      [6,      'Diamonds'],
      [9,      'Spades'],
      ['King', 'Diamonds'],
      [6,      'Hearts'],
    ].each {|card| hand << Card.new(*card)}
    assert_equal Fifthcard.decode(hand), Card.new(10, 'Diamonds')
  end

  def test_sorting_cards_sorts_by_value
    one = Card.new(1, 'Spades')
    two = Card.new(2, 'Spades')
    assert_equal [one, two], Fifthcard.sort_cards([two, one])
  end

  def test_sorting_cards_breaks_ties_by_suit
    heart = Card.new(1, "Hearts")
    spade = Card.new(1, "Spades")
    assert_equal [heart, spade], Fifthcard.sort_cards([spade, heart])
  end
end
