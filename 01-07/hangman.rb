# require 'pry'
require 'Set'

words = ['angus',
         'onomatopeia',
         'mississippi',
         'cookies',
         'terminal',
         'illness',
         'communist',
         'dictator',
         'capitalist',
         'marxist',
         'darwinism']

def greeting(count)
  puts 'Welcome to Hangman!'
  puts
  puts 'Try to guess the word by entering letters!'
  puts
  puts "#{count} wrong answers and you will be strung up!"
end

def game_over(answer, guessed)
  puts
  puts
  puts "Answer: #{answer}"
  puts
  if complete_word?(answer, guessed)
    puts 'Congratulations!'
  else
    puts 'Sorry, you lost! Try Again!'
  end
end

def play_again_prompt
  puts 'Would you like to play again? (y/n):'
  input = gets.chomp
  if input.downcase == 'y'
    return 0
  else
    puts 'Exiting game.'
    return 1
  end
end

def finished? (turns, guessed, answer)
  turns.zero? || complete_word?(answer, guessed)
end

def complete_word?(answer, guessed)
  answer.chars.all?{|x| guessed.include? (x)}
end

def prompt_player
  puts
  puts 'Enter your guess:'
  guess = gets.chomp
end

def display_guesses(guesses)
  puts
  puts 'Guesses:'
  guesses.to_a.join.each_char {|x| print x, ' '}
  puts
end

def correct_letters(guessed, answer)
  puts 'Correct Letters:'
  guess_arr = guessed.to_a
  answer_arr = answer.scan(/./)
  answer_arr.each do |n|
    if guess_arr.include?(n)
      print (n + ' ')
    end
  end
end

def hangman(words)
  exit_condition = 0
  while exit_condition == 0
    turn_count = ARGV.empty? ? 6 : ARGV[0].to_i
    guessed = Set.new
    answer = words.sample(1)[0]
    greeting(turn_count)
    until finished?(turn_count, guessed, answer)
      guess = prompt_player
      guessed.add(guess)
      display_guesses(guessed)
      correct_letters(guessed, answer)
      unless answer.include?(guess)
        turn_count -= 1
      end
    end
    game_over(answer, guessed)
    exit_condition = play_again_prompt
  end
end

hangman(words)
