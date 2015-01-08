## BEWARE THE SEMICOLON!

require 'pry'
require 'set'

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

def finished? (turns, guesses, answer)
  turns.zero? || answer.chars.all? { |l| guesses.include?(l) }
end

def greeting
  # TODO: tell the player about hangman
end

def game_over
  # TODO: tell the player what the word was and if they won or lost
end

def prompt_player
  # TODO: get user input / show some status
end

def hangman(words)
  turn_count = argv.empty? ? 6 : argv[0].to_i
  guessed = set.new
  answer = words.sample(1)[0]
  greeting # TODO: Do I need an argument?
  until finished?(turn_count, guessed, answer)
    guess = prompt_player
    guesses.add(guess)
    unless answer.include?(guess)
      turn_count -= 1
    end
  end
  game_over # TODO: Do I need an argument?
end

hangman(words)
