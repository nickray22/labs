require 'Set'
require 'pry'

class Hangman
  
  attr_accessor :turns, :guessed, :answer

  def initialize(word_array, turn_count)
    @answer = word_array.sample(1)[0]
    @turns = turn_count
    @guessed = Set.new
  end

  def greeting
    "#{@turns} wrong answers and you will be strung up!"
  end

  def game_over
    puts
    puts
    puts "Answer: #{@answer}"
    puts
    if complete_word?
      puts 'Congratulations!'
    else
      puts 'Sorry, you lost. Try Again!'
    end
  end

  def play_again_prompt?
    puts 'Would you like to play again? (y/n):'
    input = gets.chomp
    while true
      if input.downcase == 'y'
        return true
      elsif input.downcase == 'n'
        return false
      else
        puts 'Please enter a valid selection for playing again. (y/n):'
        input = gets.chomp
      end
    end
  end

  def finished?
    @turns.zero? || complete_word?
  end

  def complete_word?
    @answer.chars.all? { |c| @guessed.include?(c) }
  end

  def prompt_player
    puts
    puts 'Enter your guess:'
    guess = gets.chomp
    while true
      format = guess.scan(/[a-zA-Z]/).size
      if (format == 1)
        return guess.downcase
      else
        puts 'Please enter a valid guess:'
        guess = gets.chomp
      end
    end
  end

  def display_guesses
    puts
    puts 'Guesses:'
    @guessed.to_a.join.each_char { |c| print c, ' ' }
    puts
  end

  def correct_letters
    puts 'Correct Letters:'
    guess_arr = @guessed.to_a
    answer_arr = @answer.scan(/./)
    answer_arr.each do |c|
      if guess_arr.include?(c)
        print (c + ' ')
      else 
        print ' - '
      end
    end
  end

  def take_turn
    guess = prompt_player
    @guessed.add(guess)
    display_guesses
    correct_letters
    unless @answer.include?(guess)
      @turns -= 1
    end
  end
end

array1 = %w(angus onomatopeia mississippi cookies terminal rocks)
array2 = %w(illness communist dictator capitalist marxist darwinism)

puts 'Welcome to Hangman!'
puts
puts 'Try to guess the word by entering the letters.'
puts

game_1 = Hangman.new(array1, 6)
game_2 = Hangman.new(array2, 6)

puts "For Game 1: " + game_1.greeting
puts "For Game 2: " + game_2.greeting

until (game_1.finished?) && (game_2.finished?)
  puts
  puts
  puts "Game 1:"
  game_1.take_turn
  puts
  puts
  puts "Game 2:"
  game_2.take_turn
end

game_1.game_over
game_2.game_over

