class Player
  def initialize(name, hand)
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
    @name = name
    @cards_in_hand = hand
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Card
  SUITS = ['clubs', 'diamonds', 'hearts', 'spades']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King']

  def initialize(rank, suit, face_up = false)
    # what are the "states" of a card?
    @face_up = face_up
    @card = [rank, suit]
  end
end

class Deck

  attr_reader :cards

  def initialize
    @cards = build_new_deck
    # obviously, we need some data structure to keep track of cards
    # array, hash, something else?

  end

  def build_new_deck
    deck = []
    Card::RANKS.each do |rank|
      Card::SUITS.each do |suit|
        deck << Card.new(rank, suit)
      end
    end
    deck.shuffle!
    deck
  end

  def get_card
    cards.pop
  end

  def deal
    # does the dealer or the deck deal?
  end
end


class Dealer < Player

  def initialize
    @deck = Deck.new
  end

  def deal

  end

end

class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
end

class Game

  attr_reader :deck

  def initialize
    @deck = Deck.new
  end

  def deal_cards
    deck.get_card
  end

  def start
     deal_cards
  #  show_initial_cards
  #  player_turn
  #  dealer_turn
  #  show_result
  end
end

Game.new.start
