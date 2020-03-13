# 52 card deck of 1 - 10, jack, queen, king, ace
# -> jack, queen, king are worth 10. Aces are worth 1 or 11
# dealer and player are initially dealt 2 cards
# The player can see their 2 cards, and one of the dealers cards
# The player can choose to hit or stay
# -> The player can hit as many times as they want, unless they bust
# -> If the player busts, the dealer wins
# The dealer hits until they go over 17 or bust

GOAL = 21
DEALER_STOP = 17

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  deck = []
  4.times do
    (2..10).each { |i| deck << i }
    deck << 'Jack'
    deck << 'Queen'
    deck << 'King'
    deck << 'Ace'
  end
  deck
end

def hit!(player, deck, status)
  card = deck.shuffle!.pop
  status[player][:cards] << card
end

def initial_deal(deck, status)
  status.each_key do |agent|
    2.times do
      hit!(agent, deck, status)
      update_total!(agent, status)
    end
  end
end

def update_total!(player, status)
  case status[player][:cards].last
  when Integer
    status[player][:card_sum] += status[player][:cards].last
  when 'Jack', 'Queen', 'King'
    status[player][:card_sum] += 10
  when 'Ace'
    status[player][:card_sum] += 11
    correct_aces!(player, status)
  end
end

def correct_aces!(player, status)
  if status[player][:card_sum] > GOAL
    status[player][:card_sum] -= 10
  end
end

def update_busted!(player, status)
  if status[player][:card_sum] > GOAL
    status[player][:busted] = true
  end
end

def take_turn(player, deck, status)
  hit!(player, deck, status)
  update_total!(player, status)
  update_busted!(player, status)
end

def hit_or_stay
  player_turn = nil
  loop do
    prompt '(h)it or (s)tay?'
    player_turn = gets.chomp
    break if ['h', 's', 'hit', 'stay'].include?(player_turn)
  end
  player_turn[0]
end

def winner(status)
  if status[:player][:busted] && status[:dealer][:busted]
    'Tie'
  elsif status[:player][:busted]
    'Dealer'
  elsif status[:dealer][:busted]
    'Player'
  elsif status[:player][:card_sum] > status[:dealer][:card_sum]
    'Player'
  elsif status[:player][:card_sum] < status[:dealer][:card_sum]
    'Dealer'
  else
    'Tie'
  end
end

# Main game loop
loop do
  system 'clear'
  deck = initialize_deck
  status = { player: { cards: [], busted: false, card_sum: 0 },
             dealer: { cards: [], busted: false, card_sum: 0 } }
  initial_deal(deck, status)

  # Player turn
  loop do
    prompt "Dealer Hand: #{status[:dealer][:cards].first} and an unknown card"
    prompt "Player Hand: #{status[:player][:cards].join(', ')}"
    puts ''

    player_turn = hit_or_stay
    break if player_turn.downcase.start_with?('s')

    take_turn(:player, deck, status)
    if status[:player][:busted]
      prompt 'You have busted!'
      break
    end
    system 'clear'
  end

  # Dealer turn
  unless status[:player][:busted]
    while status[:dealer][:card_sum] < DEALER_STOP
      take_turn(:dealer, deck, status)
      prompt "Dealer drew #{status[:dealer][:cards][-1]}..."
    end
  end

  if status[:dealer][:busted]
    prompt 'Dealer has busted!'
  else
    prompt 'Dealer stays...'
  end

  # Results
  puts ''
  prompt "Dealer had #{status[:dealer][:card_sum]} " \
         "(#{status[:dealer][:cards].join(', ')})"
  prompt "Player had #{status[:player][:card_sum]} " \
         "(#{status[:player][:cards].join(', ')})"
  puts ''

  if winner(status) == 'Tie'
    prompt "It's a tie!"
  else
    prompt "#{winner(status)} wins!"
  end

  puts ''
  prompt 'Play Again? (y/n)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt 'Thanks for playing!'
