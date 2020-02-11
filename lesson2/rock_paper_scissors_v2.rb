VALID_CHOICES = %w(rock paper scissors lizard Spock)

def prompt(message)
  puts("=> #{message}")
end

def map(input)
  case input
  when 'r'
    'rock'
  when 'p'
    'paper'
  when 's'
    'scissors'
  when 'l'
    'lizard'
  when 'S'
    'Spock'
  end
end

def win?(first, second)
  case first
  when 'rock'
    if ['scissors', 'lizard'].include?(second)
      true
    end
  when 'scissors'
    if ['paper', 'lizard'].include?(second)
      true
    end
  when 'paper'
    if ['rock', 'Spock'].include?(second)
      true
    end
  when 'lizard'
    if ['Spock', 'paper'].include?(second)
      true
    end
  when 'Spock'
    if ['scissors', 'rock'].include?(second)
      true
    end
  end
  false
end

def return_winner(player, computer)
  if win?(player, computer)
    'player'
  elsif win?(computer, player)
    'computer'
  else
    'draw'
  end
end

def declare_winner(winner)
  prompt("The match is over!")
  prompt("The grand winner is... #{winner}!")
end

player_score = 0
computer_score = 0

loop do
  loop do
    choice = ''
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = gets.chomp

      if VALID_CHOICES.include?(choice)
        break
      else
        choice = map(choice)
        break if VALID_CHOICES.include?(choice)
        prompt('That\'s not a valid choice!')
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose #{choice}; Computer chose #{computer_choice}")

    if return_winner(choice, computer_choice) == 'player'
      prompt 'You won!'
      player_score += 1
    elsif return_winner(choice, computer_choice) == 'computer'
      prompt 'You lost!'
      computer_score += 1
    else
      prompt 'It\'s a tie!'
    end

    prompt("You: #{player_score}. Computer: #{computer_score}")

    break if player_score == 5 || computer_score == 5
  end

  declare_winner player_score == 5 ? 'You' : 'The computer'

  prompt("The final score was You: #{player_score}; Computer #{computer_score}")

  prompt('Do you want to play again?')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
  player_score = 0
  computer_score = 0
end

prompt('Thanks for playing! Goodbye!')
