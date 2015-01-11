# Nick

def greeting
  `clear`
puts"

___________.__         ___________               ___________            
\__    ___/|__| ____   \__    ___/____    ____   \__    ___/___   ____  
  |    |   |  |/ ___\    |    |  \__  \ _/ ___\    |    | /  _ \_/ __ \ 
  |    |   |  \  \___    |    |   / __ \\  \___    |    |(  <_> )  ___/ 
  |____|   |__|\___  >   |____|  (____  /\___  >   |____| \____/ \___  >
                   \/                 \/     \/                      \/ " 
  puts "
  Welcome to Tic-Tac-Toe!

  There are two boards displayed below, the board on the left represents the current state of the board in X's and O's,
  while the board on the right lists the available numbers (0 - 9) where a player can place the corresponding X or O
  depending on the turn. To play, pick your spot and enter that number at the prompt.

  Good luck!                                                                         
  "
end

def pick_player_details
  player_details = []
  puts 'Will player one be a human or the computer? (h or c):'
  player1_type = gets.chomp
  while true
    if (player1_type.downcase == 'h') || (player1_type.downcase == 'c')
      player_details << player1_type.downcase
      break
    else
      puts 'Please enter a valid selection for player one (h or c):'
      player1_type = gets.chomp
    end
  end
  puts 'Will player one be the X or the O? (X or O):'
  player1_symbol = gets.chomp
  while true
    if (player1_symbol.upcase == 'X') || (player1_symbol.upcase == 'O')
      player_details << player1_symbol.upcase
      break
    else
      puts 'Please enter a valid selection for player 1 (X or O):'
      player1_symbol = gets.chomp
    end
  end
  puts 'Will player two be a human or the computer? (h or c):'
  player2_type = gets.chomp
  while true
    if (player2_type.downcase == 'h') || (player2_type.downcase == 'c')
      player_details << player2_type.downcase
      break
    else
      puts 'Please enter a valid selection for player one (h or c):'
      player2_type = gets.chomp
    end
  end
  if player1_symbol.upcase == 'X'
    player2_symbol = 'O'
  else
    player2_symbol = 'X'
  end
  player_details << player2_symbol
  player_details
end

def gameboard(state)
  current = state
  moves = []
  state.each_with_index do |n, i|
    if n == ' '
      moves << i + 1
    else
      moves << '-'
    end
  end
  puts "
  Game Board:      Available Moves:

  #{current[0]} | #{current[1]} | #{current[2]}          #{moves[0]} | #{moves[1]} | #{moves[2]} 
  ---------          ---------
  #{current[3]} | #{current[4]} | #{current[5]}          #{moves[3]} | #{moves[4]} | #{moves[5]} 
  ---------          ---------
  #{current[6]} | #{current[7]} | #{current[8]}          #{moves[6]} | #{moves[7]} | #{moves[8]} 

  "
end

def easy_input(state, player_symbol, player_type)
  current = state
  moves = []
  state.each_with_index do |n, i|
    if n == ' '
      moves << i + 1
    else
      moves << '-'
    end
  end
  if player_type == 'h'
    puts 'Enter your move:'
    input = gets.chomp
    while true 
      if (input.scan(/[a-zA-Z]+/).empty?) && (moves.include?(input.to_i))
        input = input.to_i
        break
      else
        puts 'Please enter one of the numbers listed as a valid move on the board.'
        puts 'Enter your move:'
        input = gets.chomp
      end
    end
    if player_symbol == 'X'
      current[input - 1] = 'X'
    else
      current[input - 1] = 'O'
    end
  else
    moves = moves.delete_if { |x| x == '-' }
    computer_move = moves.sample
    if player_symbol == 'X'
      current[computer_move - 1] = 'X'
    else
      current[computer_move - 1] = 'O'
    end
  end
  current
end

def continue_game?(state)
  winning_combinations = [[0,1,2], [3,4,5], [6,7,8], [0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]]
  current = state
  winning_combinations.each do |n|
    win_check = []
    n.each do |i|
      win_check << current[i]
    end
    if (win_check.uniq.size == 1) && (win_check.first != ' ')
      puts "'#{win_check.first}' Wins! Good Game."
      puts
      return false
    end
  end
  unless current.include?(' ')
    puts "This game has resulted in a tie. Thanks for playing."
    puts 
    return false
  end
  true
end

def play_game
  beginning_state = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  greeting
  gameboard(beginning_state)
  player_details = pick_player_details
  gameboard(beginning_state)
  count = 0
  new_state = []
  playing_game = true
  while playing_game
    if count == 0
      new_state = easy_input(beginning_state, player_details[1], player_details[0])
      count += 1
      gameboard(new_state)
    elsif count.odd?
      new_state = easy_input(new_state, player_details[3], player_details[2])
      count += 1
      gameboard(new_state)
      playing_game = continue_game?(new_state)
    else
      new_state = easy_input(new_state, player_details[1], player_details[0])
      count += 1
      gameboard(new_state)
      playing_game = continue_game?(new_state)
    end
  end
end

play_game
