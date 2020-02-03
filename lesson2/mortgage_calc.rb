# Welcome the user
# Ask for: the loan amount (float); the APR (float); the loan duration (int)
# use the above information to return the monthly interest rate (%float); the loan duration (int)


def message(msg)
  puts msg = "=> #{msg}"
end

def valid_float?(loan_amount)
  loan_amount.to_i > 0 && loan_amount.to_f.to_s == Float(loan_amount).to_s
end

message("This program helps you calculate your loan information")

message("What is the loan amount? (Round to the nearest whole number)")
loan_amount = ''

loop do
  loan_amount = gets.chomp
  if loan_amount = valid_float?(loan_amount)
    break
  else
    message("Oops! Please enter a valid loan amount!")
  end
end

message("What is the APR?")
apr = ''

loop do
  apr = gets.chomp
  if apr = valid_float?(apr)
    break
  else
    message("Oops! Please enter a valid APR!")
  end
end


