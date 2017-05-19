class Player
  attr_accessor :move, :name

  def initialize(player_type = :human)
    @move = nil
    set_name
  end

end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    puts "Please choose rock, paper, or scissors:"
    choice = nil
    loop do
      choice = gets.chomp
      break if ['rock', 'paper', 'scissors'].include? choice
      puts "Sorry, invalid choice!"
    end
    self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Number 5'].sample
  end

  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
  end
end

class RPSGame

  attr_reader :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new(:computer)
  end

  def play_again?#
    answer = ''
    loop do
      puts "Would you like to play again (y/n)?"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def play
    display_welcome_message

    loop do
    human.choose
    computer.choose
    display_winner
    break unless play_again?
    end

    display_goodbye_message
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}"

    case human.move
    when 'rock'
      puts "It's a tie!" if computer.move == 'rock'
      puts "#{human.name} won!" if computer.move == 'scissors'
      puts "#{computer.name} won!" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie!" if computer.move == 'paper'
      puts "#{human.name} won!" if computer.move == 'rock'
      puts "#{computer.name} won!" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie!" if computer.move == 'scissors'
      puts "#{human.name} won!" if computer.move == 'paper'
      puts "#{computer.name} won!" if computer.move == 'rock'
    end
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissor game!"
  end

  def display_goodbye_message
    puts "Thanks for playing! Goodbye!"
  end
end

RPSGame.new.play
