# 52 card deck of 1 - 10, jack, queen, king, ace
# -> jack, queen, king are worth 10. Aces are worth 1 or 11
# dealer and player are initially dealt 2 cards
# The player can see their 2 cards, and one of the dealers cards
# The player can choose to hit or stay
# -> The player can hit as many times as they want, unless they bust
# -> If the player busts, the dealer wins
# The dealer hits until they go over 17 or bust

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

def hit!(player, deck, hand)
  card = deck.shuffle!.pop
  hand[player] << card
end

def initial_deal(deck, hand)
  hand.each_key do |actor|
    2.times do
      hit!(actor, deck, hand)
    end
  end
end

def card_total(player, hand)
  total = 0
  hand[player].reject { |card| card == 'Ace' }.each do |card|
    case card
    when Integer
      total += card
    when 'Jack', 'Queen', 'King'
      total += 10
    end
  end
  total += ace_value(player, hand, total) if hand[player].include?('Ace')
  total
end

def ace_value(player, hand, total)
  if hand[player].select { |card| card == 'Ace' }.count > 1
    hand[player].select { |card| card == 'Ace' }.count
  else
    total + 11 > 21 ? 1 : 11
  end
end

def bust?(player, hand)
  card_total(player, hand) > 21
end

def dealer_turn(deck, hand)
    hit!(:dealer, deck, hand)
end

def winner(hand)
  if bust?(:player, hand) && bust?(:dealer, hand)
    'Tie'
  elsif bust?(:player, hand)
    'Dealer'
  elsif bust?(:dealer, hand)
    'Player'
  elsif card_total(:player, hand) > card_total(:dealer, hand)
    'Player'
  elsif card_total(:player, hand) < card_total(:dealer, hand)
    'Dealer'
  else
    'Tie'
  end
end

# Main game loop
loop do
  system 'clear'
  deck = initialize_deck
  hand = { player: [],
           dealer: [] }
  initial_deal(deck, hand)

  # Player turn
  loop do
    prompt "Dealer Hand: #{hand[:dealer].first} and an unknown card"
    prompt "Player Hand: #{hand[:player].join(', ')}"
    puts ''

    player_turn = nil
    loop do
      prompt '(h)it or (s)tay?'
      player_turn = gets.chomp
      break if ['h', 's'].include?(player_turn[0])
    end

    break unless player_turn.downcase.start_with?('h')
    hit!(:player, deck, hand)
    if bust?(:player, hand)
      prompt 'You are bust!'
      break
    end
    system 'clear'
  end

  # Dealer turn
  unless bust?(:player, hand)
    while card_total(:dealer, hand) < 17
      dealer_turn(deck, hand)
      prompt "Dealer drew #{hand[:dealer][-1]}..."
    end
    prompt "Dealer stays"
  end

  # Results
  puts ''
  prompt "Dealer had #{card_total(:dealer, hand)} " \
         "(#{hand[:dealer].join(', ')})"
  prompt "Player had #{card_total(:player, hand)} " \
         "(#{hand[:player].join(', ')})"
  puts ''

  if bust?(:dealer, hand)
    prompt 'Dealer is bust!'
  end

  if winner(hand) == 'Tie'
    prompt "It's a tie!"
  else
    prompt "#{winner(hand)} wins!"
  end

  puts ''
  prompt 'Play Again? (y/n)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt 'Thanks for playing!'
