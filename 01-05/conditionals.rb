# Nick Ray

number = rand(99) + 1

puts 'I have a number between 1 and 100, inclusive.'
puts 'Can you guess it?'

loop do
  puts 'Enter your guess (as a number):'
  guess = gets.chomp.to_i

  if guess == number
    puts 'Congratulations! You got it right.'
    break
  elsif guess < number
    puts 'Your guess is less than the number I have. Try again.'
  else
    puts 'Your guess is higher than the number I have. Try again.'
  end
end
