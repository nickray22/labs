# require 'pry'

def greeting
  `clear`
  puts "\nWelcome to Tic-Tac-Toe!\n\nThere are two boards displayed below, the board on the left represents the current state of the board in X's and O's,\nwhile the board on the right lists the available numbers (1 - 9) where a player can place the corresponding X or O\ndepending on the turn. To play, pick your spot and enter that number at the prompt.\n\nGood luck!\n\n"
end

class HumanPlayer
  attr_accessor :state, :moves

  def initialize
    @state = []
    @moves = []
  end

  def input_move(player_number, player_details, state)
    @state = state
    @state.each_with_index do |n, i|
      if n == ' '
        @moves << i + 1
      else
        @moves << '-'
      end
    end
    puts 'Enter your move:'
    input = gets.chomp
    loop do
      if (input.scan(/[a-zA-Z]+/).empty?) && (moves.include?(input.to_i))
        input = input.to_i
        break
      else
        puts 'Please enter one of the numbers listed as a valid move on the board.'
        puts 'Enter your move:'
        input = gets.chomp
      end
    end
    if player_number == 1
      @state[input - 1] = player_details['player1_symbol']
    else
      @state[input - 1] = player_details['player2_symbol']
    end
    @state
  end
end

class ComputerPlayer
  attr_accessor :state, :moves

  def initialize
    @state = []
    @moves = []
  end

  def input_move(player_number, player_details, state)
    @state = state
    @state.each_with_index do |n, i|
      if n == ' '
        @moves << i
      end
    end
    computer_move = @moves.sample
    if player_number == 1
      @state[computer_move] = player_details['player1_symbol']
    else
      @state[computer_move] = player_details['player2_symbol']
    end
    @state
  end
end

class Board
  attr_accessor :moves, :x_win, :x_loss, :x_draw, :o_win, :o_loss, :o_draw
  attr_reader :state, :player_details

  def initialize
    @state = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @moves = []
    @x_win = 0
    @x_loss = 0
    @x_draw = 0
    @o_win = 0
    @o_loss = 0
    @o_draw = 0
    @player_details = {}
  end

  def gameboard(state)
    @state = state
    @state.each_with_index do |n, i|
      if n == ' '
        @moves << i + 1
      else
        @moves << '-'
      end
    end
    puts "
    Game Board:      Available Moves:

    #{@state[0]} | #{@state[1]} | #{@state[2]}          #{@moves[0]} | #{@moves[1]} | #{@moves[2]} 
    ---------          ---------
    #{@state[3]} | #{@state[4]} | #{@state[5]}          #{@moves[3]} | #{@moves[4]} | #{@moves[5]} 
    ---------          ---------
    #{@state[6]} | #{@state[7]} | #{@state[8]}          #{@moves[6]} | #{@moves[7]} | #{@moves[8]} "
  end

  def scoreboard
    puts
    puts "
    Player Number:    Player Type:    Player Symbol:    Wins:   Losses:   Draws:
  ------------------------------------------------------------------------------
          1                 #{@player_details['player1_type'].upcase}             '#{@player_details['player1_symbol']}'            #{get_wins(1)}        #{get_losses(1)}        #{get_draws(1)}   
          2                 #{@player_details['player2_type'].upcase}             '#{@player_details['player2_symbol']}'            #{get_wins(2)}        #{get_losses(2)}        #{get_draws(2)}"
    puts
  end

  def pick_p1_type
    puts
    puts 'Will player one be a human or the computer? (h or c):'
    player1_type = gets.chomp
    loop do
      if (player1_type.downcase == 'h') || (player1_type.downcase == 'c')
        @player_details['player1_type'] = player1_type.downcase
        break
      else
        puts 'Please enter a valid selection for player one (h or c):'
        player1_type = gets.chomp
      end
    end
  end

  def pick_p1_symbol
    puts
    puts 'Will player one be the X or the O? (X or O):'
    player1_symbol = gets.chomp
    loop do
      if (player1_symbol.upcase == 'X') || (player1_symbol.upcase == 'O')
        @player_details['player1_symbol'] = player1_symbol.upcase
        break
      else
        puts 'Please enter a valid selection for player one (X or O):'
        player1_symbol = gets.chomp
      end
    end
  end

  def pick_p2_type
    puts
    puts 'Will player two be a human or the computer? (h or c):'
    player2_type = gets.chomp
    loop do
      if (player2_type.downcase == 'h') || (player2_type.downcase == 'c')
        @player_details['player2_type'] = player2_type.downcase
        break
      else
        puts 'Please enter a valid selection for player two (h or c):'
        player2_type = gets.chomp
      end
    end
  end

  def pick_p2_symbol
    if @player_details['player1_symbol'] == 'X'
      @player_details['player2_symbol'] = 'O'
    else
      @player_details['player2_symbol'] = 'X'
    end
    puts "\nPlayer one will be represented by the '#{@player_details['player1_symbol']}' symbol and player two will be represented by the '#{@player_details['player2_symbol']}' symbol\n"
  end

  def get_wins(player_number)
    if player_number == 1
      if @player_details['player1_symbol'] == 'X'
        @x_win
      else
        @o_win
      end
    else
      if @player_details['player2_symbol'] == 'X'
        @x_win
      else
        @o_win
      end
    end
  end

  def get_losses(player_number)
    if player_number == 1
      if @player_details['player1_symbol'] == 'X'
        @x_loss
      else
        @o_loss
      end
    else
      if @player_details['player2_symbol'] == 'X'
        @x_loss
      else
        @o_loss
      end
    end
  end

  def get_draws(player_number)
    if player_number == 1
      if @player_details['player1_symbol'] == 'X'
        @x_draw
      else
        @o_draw
      end
    else
      if @player_details['player2_symbol'] == 'X'
        @x_draw
      else
        @o_draw
      end
    end
  end

  def get_details
    @player_details
  end

  def add_o_win
    @o_win += 1
  end

  def add_o_loss
    @o_loss += 1
  end

  def add_o_draw
    @o_draw += 1
  end

  def add_x_win
    @x_win += 1
  end

  def add_x_loss
    @x_loss += 1
  end

  def add_x_draw
    @x_draw += 1
  end

  def get_state
    @state
  end
end

class Game
  attr_accessor :player_details, :boards

  def initialize
    greeting
    @boards = Board.new
    @boards.gameboard(@boards.get_state)
    @boards.pick_p1_type
    @boards.pick_p1_symbol
    @boards.pick_p2_type
    @boards.pick_p2_symbol
    @player_details = @boards.get_details
    @boards.scoreboard
  end

  def continue_game?(state)
    winning_combinations = [[0, 1, 2],
                            [3, 4, 5],
                            [6, 7, 8],
                            [0, 4, 8],
                            [2, 4, 6],
                            [0, 3, 6],
                            [1, 4, 7],
                            [2, 5, 8]]
    winning_combinations.each do |n|
      win_check = []
      n.each do |i|
        win_check << state[i]
      end
      if (win_check.uniq.size == 1) && (win_check.first != ' ')
        puts
        puts
        puts "'#{win_check.first}' Wins! Good Game"
        puts
        if win_check.first == 'X'
          @boards.add_x_win
          @boards.add_o_loss
          @boards.scoreboard
        else
          @boards.add_o_win
          @boards.add_x_loss
          @boards.scoreboard
        end
        return false
      end
    end
    unless state.include?(' ')
      puts
      puts
      puts 'This game has resulted in a tie. Thanks for playing.'
      puts
      @boards.add_x_draw
      @boards.add_o_draw
      @boards.scoreboard
      return false
    end
    true
  end

  def play_again?
    loop do
      print 'Would you like to play again? [y/n]:'
      result = gets.chomp.downcase
      if result == 'y'
        ttt = Game.new
        ttt.play_game
      else
        exit
      end
    end
  end

  def play_game
    if @player_details['player1_type'] == 'h'
      player1 = HumanPlayer.new
    else
      player1 = ComputerPlayer.new
    end
    if @player_details['player2_type'] == 'h'
      player2 = HumanPlayer.new
    else
      player2 = ComputerPlayer.new
    end
    count = 0
    playing_game = true
    while playing_game
      if count.even?
        new_state = player1.input_move(1, @player_details, @boards.get_state)
        @boards.gameboard(new_state)
        playing_game = continue_game?(new_state)
        count += 1
      else
        new_state = player2.input_move(2, @player_details, @boards.get_state)
        @boards.gameboard(new_state)
        playing_game = continue_game?(new_state)
        count += 1
      end
    end
    play_again? == true
  end
end

ttt = Game.new
ttt.play_game
