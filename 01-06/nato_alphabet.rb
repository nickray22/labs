alphabet = {'a' => 'alpha','b' => 'bravo','c' => 'charlie','d' => 'delta','e' => 'echo','f' => 'foxtrot','g' => 'golf','h' => 'hotel','i' => 'india','j' => 'juliett','k' => 'kilo','l' => 'lima','m' => 'mike','n' => 'november','o' => 'oscar','p' => 'papa','q' => 'quebec','r' => 'romeo','s' => 'sierra','t' => 'tango','u' => 'uniform','v' => 'victor','w' => 'whiskey','x' => 'xray','y' => 'yankee','z' => 'zulu'}

def encode(msg, alphabet)
  new_msg = []
  msg.downcase!
  msg.each_char do |c|
    if alphabet.has_key?(c)
    new_msg << alphabet[c] + ' '
    else
      new_msg << c
    end
  end
  new_msg.join()
end

def decode(msg, alphabet)
  new_msg = []
  msg.downcase!
  alphabet = alphabet.invert
  my_msg = msg.split(/\s/)
  my_msg.each do |c|
    if alphabet.has_key?(c)
      new_msg << alphabet[c]
    elsif c == ''
      new_msg << ' '
    else
      new_msg << c
    end
  end
  new_msg.join()
end

puts 'Please input a message to encode:'
user_msg = gets.chomp
puts
puts 'Encoded message:'
user_encode = encode(user_msg, alphabet)
puts user_encode
puts
puts 'Decoded message:'
puts decode(user_encode, alphabet)
