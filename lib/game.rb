require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'cell_value.rb'

class Game
  attr_reader :grid, :player_1, :player_2
  $winning_moves =
    [[0, 1 ,2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]]

  def initialize
    @grid = Board.new
    @player_1 = Player.new
    @player_2 = Player.new
    @winner = nil
    @current_turn = 1
  end

  def play
    how_many_players
    if @number_of_players == 2
      start_playing
    elsif @number_of_players == 1
      play_vs_computer
    else
      puts "only 1 or 2 players please"
    end
    greeting_and_names
    determine_winner
    game_finished
  end

  def how_many_players
    puts "-----{}-----{}-----{}-----{}---"
    puts "|  Welcome to tic tac toe!    |"
    puts "{}-----{}-----{}-----{}-----{}-"
    puts "|       how many people       |"
    puts "|      are playing today?     |"
    puts "|                             |"
    puts "|         type 1 to           |"
    puts "|        play against the     |"
    puts "|          computer           |"
    puts "|          type 2 to          |"
    puts "|        player against       |"
    puts "|         another person      |"
    puts "|                             |"
    puts "-----{}-----{}-----{}-----{}---"
    print "type 1 or 2> "
    @number_of_players = gets.chomp
  end

  #here we have a greeting, an explanation of the board structure, and we ask for the players name
  def greeting_and_names
    puts "-----{}-----{}-----{}-----{}---"
    puts "|         tic tac toe         |"
    puts "{}-----{}-----{}-----{}-----{}-"
    puts "|        the board is         |"
    puts "|        numbered 1-9         |"
    puts "|          like this          |"
    puts "|                             |"
    puts "|          1 | 2 | 3          |"
    puts "|          4 | 5 | 6          |"
    puts "|          7 | 8 | 9          |"
    puts "|                             |"
    puts "-----{}-----{}-----{}-----{}---"
    print "player x what's your name? "
    @player_1.name = gets.chomp
    @player_1.sym = 'X'
    print "player O what's your name? "
    @player_2.name = gets.chomp
    @player_2.sym = 'O'
  end
  def play_vs_computer
    puts "-----{}-----{}-----{}-----{}---"
    puts "|         tic tac toe         |"
    puts "{}-----{}-----{}-----{}-----{}-"
    puts "|        the board is         |"
    puts "|        numbered 1-9         |"
    puts "|          like this          |"
    puts "|                             |"
    puts "|          1 | 2 | 3          |"
    puts "|          4 | 5 | 6          |"
    puts "|          7 | 8 | 9          |"
    puts "|                             |"
    puts "-----{}-----{}-----{}-----{}---"
    puts "You are playing against the most advanced machine to ever play tic tac toe. His name is Dave."
    @player_2.name = computer_player
    @player_2.sym = 'O'
    puts "What is your name?"
    player_1.name = gets.chomp
    player_1.sym = 'X'
  end

  def start_playing
    take_turns until game_over
  end

  #if the current turn is even the first player goes. if not the second.
  def take_turns
    @current_turn % 2 == 0 ? turn(@player_1) : turn(@player_2)
  end

  def turn(player)
    current_play(player)
    input = solicit_move
    if @grid.update(input, player.sym)
      @current_turn += 1
    else
      error = "That ain't happening"
    end
    @grid.print_grid
    puts error
    check_for_win(player)
  end


  def current_play(player)
    puts "Turn: #{@current_turn}"
    print "#{player.name} (#{player.sym}) "
  end

  def solicit_move
    input = nil
    until (0..8).include?(input)
      print 'Type the number where youd like to move'
      input = gets.chomp.to_i - 1
    end
    input
  end

  #this one is a doozy. we go threw the list of all possible winning combinations
  #and declare one of the players a winner if he has played his symbol on those squares
  def check_for_win(player)
    $winning_moves.each do |n|
      @winner = player if n.all? { |board_space| @grid.board[board_space] == player.sym }
    end
  end

  def game_over
    @current_turn > 9 || @winner
  end

  def game_finished
    puts "-----{}-----{}-----{}-----{}---"
    puts "|         Game Over           |"
    puts "{}-----{}-----{}-----{}-----{}-"
  end

  def determine_winner
    if @current_turn > 9 && !@winner
      puts "Stalemet :-/"
    else
      puts "WINNER WINNER CHICKEN DINNER, #{@winner.name}."
    end
  end
    Player = Struct.new(:name, :sym)
end
