# Welcome the user
# Ask for: the loan amount (float); the APR (float); the loan duration (int)
# return the monthly interest rate (%float); the loan duration (int)

def message(msg)
  puts "=> #{msg}"
end

def valid_number?(input)
  integer?(input) || float?(input)
end

def integer?(input)
  Integer(input) rescue false
end

def float?(input)
  Float(input) rescue false
end

message("This program helps you calculate your loan information")

message("What is the loan amount? (Round to the nearest whole number)")
loan_amount = ''

loop do
  loan_amount = gets.chomp
  if valid_number?(loan_amount) && loan_amount.to_f > 0
    loan_amount = loan_amount.to_f
    break
  else
    message("Oops! Please enter a valid loan amount!")
  end
end

message("What is the APR? e.g. 5.4 for 5.4%")
apr = ''
monthly_rate = ''

loop do
  apr = gets.chomp
  if valid_number?(apr) && apr.to_f >= 0
    monthly_rate = apr.to_f / 12 / 100
    break
  else
    message("Oops! Please enter a valid APR!")
  end
end

message("What is the loan duration (in years)?")
loan_duration = ''

loop do
  loan_duration = gets.chomp
  if valid_number?(loan_duration) && loan_duration.to_f > 0
    loan_duration = loan_duration.to_f * 12
    break
  else
    message("Oops! Please enter a valid loan_duration!")
  end
end

monthly_payment = loan_amount * (monthly_rate / 
                  (1 - (1 + monthly_rate)**(-loan_duration)))

message("Your monthly payment is $#{monthly_payment.round(2)}")
