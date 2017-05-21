module Prompt
  def prompt(message = '')
    puts "==> #{message}"
  end
end

class Card
  include Prompt
  SUITS = ['clubs', 'diamonds', 'hearts', 'spades']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
           'Jack', 'Queen', 'King', 'Ace']

  attr_reader :card

  def initialize(rank, suit, face_up = true)
    @card = [rank, suit]
    @face_up = face_up
  end

  def display
    if @face_up
      prompt "#{card[0]} of #{card[1]}"
    else
      prompt "### card face down ###"
    end
  end

  def rank
    card[0]
  end

  def suit
    card[1]
  end

  def face_down!
    @face_up = false
  end

  def face_up!
    @face_up = true
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = build_new_deck
  end

  def deal_card
    cards.pop
  end

  def reset
    @cards = build_new_deck
  end

  private

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
end

class Participant
  include Prompt

  attr_accessor :name

  def initialize
    @name = ''
    @cards = []
  end

  def bust?
    total > 21
  end

  def clear_hand
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def total
    total = 0
    aces  = 0
    @cards.each do |card|
      if card.rank == 'Ace'
        aces += 1
      else
        total += card.rank.to_i == 0 ? 10 : card.rank.to_i
      end
    end
    aces.times do
      total += (total + 11) <= 21 ? 11 : 1
    end
    total
  end

  def show_hand
    @cards.each(&:display)
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      prompt "What's your name?"
      name = gets.chomp.strip
      break unless name.empty?
      prompt "Sorry! Name should be at least one character!"
    end
    self.name = name
  end

  def show_hand
    prompt "Player #{name} hand:"
    super
  end
end

class Dealer < Participant
  #---
  NAMES = ['Hal', 'R2D2', 'C64', 'Spectrum']

  def set_name
    self.name = NAMES.sample
  end

  def show_hand
    prompt "Dealer #{name} hand:"
    super
  end

  def cards_face_up!
    @cards.each(&:face_up!)
  end

  def add_card(card)
    super
    @cards.first.face_down! unless @cards.empty?
  end
end

class Game
  include Prompt

  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def deal_card_to(plr)
    plr.add_card(deck.deal_card)
  end

  def deal_initial_cards
    2.times do
      player.add_card(deck.deal_card)
      dealer.add_card(deck.deal_card)
    end
  end

  def clear
    system 'clear'
  end

  def display_cards
    clear
    player.show_hand
    prompt
    dealer.show_hand
    prompt
    prompt "Player #{player.name} total: #{player.total}"
  end

  def display_welcome_message
    clear
    prompt 'Welcome to twenty-one game!'
  end

  def display_goodbye_message
    prompt 'Thanks for playing! Goodbye!'
  end

  def player_turn
    loop do
      move = ''
      loop do
        prompt
        prompt "#{player.name} do you want to (H)it or (S)tay?"
        move = gets.chomp.upcase
        break if %w[H S].include?(move)
        prompt "Sorry! Please chose 'H' or 'S'!"
      end
      break if move == 'S'
      deal_card_to(player)
      display_cards
      break if player.bust?
    end
  end

  def dealer_turn
    while dealer.total < 17
      deal_card_to(dealer)
      break if dealer.bust?
    end
  end

  def play_again?
    choice = ''
    loop do
      prompt 'Do you want to play again? (y/n)'
      choice = gets.chomp.downcase
      break if %w[y n].include?(choice)
      prompt 'Sorry! Incorrect input. Please enter y or n only!'
    end
    choice == 'y'
  end

  def show_dealer_total
    prompt "Dealer #{dealer.name} total: #{dealer.total}"
    prompt ''
  end

  def show_bust
    if player.bust?
      prompt 'Player bust!'
    elsif dealer.bust?
      prompt 'Dealer bust!'
    end
  end

  def show_winner
    if player.total == dealer.total
      prompt "It's a tie!"
    elsif player.total < dealer.total
      prompt "Dealer #{dealer.name} won!"
    else
      prompt "Player #{player.name} won!"
    end
  end

  def show_result
    dealer.cards_face_up!
    display_cards
    show_dealer_total
    show_bust
    show_winner unless player.bust? || dealer.bust?
  end

  def set_names
    player.set_name
    dealer.set_name
  end

  def game_reset
    deck.reset
    player.clear_hand
    dealer.clear_hand
  end

  def start
    display_welcome_message
    set_names
    loop do
      deal_initial_cards
      display_cards
      player_turn
      dealer_turn unless player.bust?
      show_result
      break unless play_again?
      game_reset
    end
    display_goodbye_message
  end
end

Game.new.start
