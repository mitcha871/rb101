def prompt(message)
  puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt('Welcome to calculator! Enter your name:')

name = ''
loop do
  name = gets.chomp

  if name == ''
    prompt('Make sure you use a valid name!')
  else
    break
  end
end

number1 = ''
number2 = ''

prompt("Hi #{name}")

loop do
  loop do
    prompt('Give me a number')
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt('Not a valid number!')
    end
  end

  loop do
    prompt('Give me another number')
    number2 = gets.chomp

    if valid_number?(number2)
      break
    else
      prompt('Not a valid number!')
    end
  end

  operator_prompt = <<-MSG # Multi line string. MSG can be anything (delimeters)
    What operation would you like to perform?
    1) Add
    2) Subtract
    3) Multiply
    4) Divide
  MSG

  prompt(operator_prompt)
  operation = ''

  loop do
    operation = gets.chomp

    if %w(1 2 3 4).include?(operation) # %w is a string array
      break
    else
      prompt('Must choose 1, 2, 3, 4')
    end
  end

  prompt("#{operation_to_message(operation)} your numbers...")

  # if operation == 1
  #   result = number1.to_i + number2.to_i
  # elsif operation == 2
  #   result = number1.to_i - number2.to_i
  # elsif operation == 3
  #   result = number1.to_i * number2.to_i
  # elsif operation == 4
  #   result = number1.to_f / number2.to_f
  # end

  result = case operation
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
           end

  prompt("Your number is #{result}")

  prompt('Do you want to do another calculation? (Y/N)')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for using the calculator!')
