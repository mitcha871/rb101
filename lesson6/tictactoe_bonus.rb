INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals
MAX_SCORE = 2
FIRST_TURN_SETTING = 'choose' # player/computer/choose

def prompt(msg)
  puts "=> #{msg}"
end

def set_first_mover
  first_mover = nil
  if FIRST_TURN_SETTING == 'choose'
    prompt "Who plays first? Player or Computer? (Choose P or C)"
    loop do
      first_mover = gets.chomp
      break if ['P', 'C'].include?(first_mover)
      prompt "Invalid input. Choose P or C."
    end
    case first_mover
    when 'P' then 'player'
    when 'C' then 'computer'
    end
  else
    FIRST_TURN_SETTING
  end
end

def alternate_player(current_player)
  if current_player == 'player'
    'computer'
  elsif current_player == 'computer'
    'player'
  end
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr[-1]}"
    arr.join(delimiter)
  end
end

def place_piece!(brd, current_player)
  if current_player == 'player'
    player_places_piece!(brd)
  elsif current_player == 'computer'
    computer_places_piece!(brd)
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, not valid!"
  end
  brd[square] = PLAYER_MARKER
end

# rubocop:disable Metrics/CyclomaticComplexity
def computer_places_piece!(brd)
  square = nil

  WINNING_LINES.each do |line|
    square = find_at_risk_square(brd, line, COMPUTER_MARKER)
    break if square
  end

  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(brd, line, PLAYER_MARKER)
      break if square
    end
  end

  square = 5 if !square && empty_squares(brd).include?(5)
  square = empty_squares(brd).sample if !square

  brd[square] = COMPUTER_MARKER
end
# rubocop:enable Metrics/CyclomaticComplexity

def find_at_risk_square(brd, line, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    # if brd[line[0]] == PLAYER_MARKER &&
    #    brd[line[1]] == PLAYER_MARKER &&
    #    brd[line[2]] == PLAYER_MARKER
    #   return 'Player'
    # elsif brd[line[0]] == COMPUTER_MARKER &&
    #       brd[line[1]] == COMPUTER_MARKER &&
    #       brd[line[2]] == COMPUTER_MARKER
    #   return 'Computer'
    # end
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

score = { player: 0, computer: 0 }
def award_point!(winner, score)
  if winner == 'Player'
    score[:player] += 1
  elsif winner == 'Computer'
    score[:computer] += 1
  end
end

# Main game logic starts here

system 'clear'
prompt "Welcome to Tic Tac Toe"

first_mover = set_first_mover

loop do
  board = initialize_board
  current_player = first_mover

  loop do
    display_board(board)
    place_piece!(board, current_player)
    break if someone_won?(board) || board_full?(board)
    current_player = alternate_player(current_player)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
    award_point!(detect_winner(board), score)
  else
    prompt "It's a tie!"
  end

  prompt "Current score is:"
  prompt "Player: #{score[:player]}"
  prompt "Computer #{score[:computer]}"

  if score.value?(MAX_SCORE)
    prompt "#{score.key(MAX_SCORE).capitalize} " \
           "is the first to #{MAX_SCORE} wins!"
    break
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
