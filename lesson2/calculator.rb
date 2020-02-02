puts "Give me a number"
number1 = gets.chomp
puts "Give me another number"
number2 = gets.chomp

puts "Select an operation: 1) add 2) subtract 3) multiply 4) divide"
operation = gets.chomp.to_i

if operation == 1
  result = number1.to_i + number2.to_i
elsif operation == 2
  result = number1.to_i - number2.to_i
elsif operation == 3
  result = number1.to_i * number2.to_i
elsif operation == 4
  result = number1.to_f / number2.to_f
end

puts "Your number is #{result}"