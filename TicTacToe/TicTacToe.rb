
class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to TicTacToe !"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing! Goodbye!"
  end

  def human_moves
      puts "Chose a square between (#{board.unmarked_keys}): "
      square = ''
      loop do
        square = gets.chomp.to_i
        break if board.unmarked_keys.include?(square)
        puts "Sorry, that's not a valid choice!"
      end

#      board.set_square_at(square, human.marker)
      board[square] = human.marker
  end

  def computer_moves
#    board.set_square_at(board.unmarked_keys.sample,computer.marker)
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a Tie!"
    end
  end

  def clear_screen
    system 'clear'
  end

  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry must be y or n"
    end
    answer == 'y'
  end

  def board_display
    puts "You're #{TTTGame::HUMAN_MARKER}, Computer is #{TTTGame::COMPUTER_MARKER}"
    board.display
    puts ""
  end

  def clear_screen_and_display_board
    clear_screen
    board_display
  end
  
  def reset
      board.reset
      clear_screen
      puts "Let's play again!"
      puts ""
  end
  
  def play
    clear_screen
    display_welcome_message

    loop do
      board_display
      loop do
        human_moves
        break if board.full? || board.someone_won

         computer_moves
         clear_screen_and_display_board
        break if board.full? || board.someone_won
      end
      display_result
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Board

  attr_accessor :marker
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def get_square_at(key)
    @squares[key]
  end

#  def set_square_at(key, marker)
#    @squares[key].marker = marker
#  end

  def []=(key, marker)
      @squares[key].marker = marker
  end
  
  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won
    !!winning_marker
  end

  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  def count_marker(squares)
    markers = squares.collect(&:marker)
  end

  def winning_marker
    WINNING_LINES.each do |line|
      if count_human_marker(@squares.values_at(*line)) == 3
         return TTTGame::HUMAN_MARKER
    elsif count_computer_marker(@squares.values_at(*line)) == 3
         return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  def display
    puts "     |     |"
    puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}"
    puts "     |     |"
  end
end

class Player

  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

TTTGame.new.play()
