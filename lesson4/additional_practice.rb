# Practice Problem 1

def practice_problem1
  flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

  result = {}

  flintstones.each_with_index do |name, index|
    result[index] = name
  end
  p result
end

def practice_problem2
  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

  total_age = 0
  # ages.each do |name, age|
  #   total_age += age.to_int
  # end

  ages.each { |_, age| total_age += age }

  p total_age
end

def practice_problem3
  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

  # ages.delete_if { |_, age| age.to_i > 99 }

  ages.keep_if { |_, age| age < 100 }

  p ages
end

def practice_problem4
  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

  # min_age = 0
  # ages.each do |_, age|
  #   min_age = age if age < min_age || min_age == 0
  # end
  # p min_age

  p ages.values.min

end

def practice_problem5
  flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

  p flintstones.index { |name| name[0,2] == 'Be' }
end

def practice_problem6
  flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
  flintstones.map! do |name|
    name[0,3]
  end
  p flintstones
end

def practice_problem7
  statement = "The Flintstones Rock"
  result = {}
  letters = ('A'..'Z').to_a + ('a'..'z').to_a
  letters.each do |letter|
    letter_frequency = statement.scan(letter).count
    result[letter] = letter_frequency if letter_frequency > 0
  end
  p result
end

def practice_problem9
  words = "the flinstones rock"
  words.split.map { |word| word.capitalize }.join(' ')
end

def practice_problem10
  munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
  }

  munsters.each do |name, details|
    case details["age"]
    when 0..18
      details["age_group"] = "kid"
    when 18..65
      details["age_group"] = "adult"
    else
      details["age_group"] = "senior"
    end
  end
  p munsters
end

practice_problem10
