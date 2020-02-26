def practice_problem1
  arr = ['10', '11', '9', '7', '8']
  arr.sort! do |a, b|
    b.to_i <=> a.to_i
  end
  p arr
end

def practice_problem2
  books = [
  { title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967' },
  { title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925' },
  { title: 'War and Peace', author: 'Leo Tolstoy', published: '1869' },
  { title: 'Ulysses', author: 'James Joyce', published: '1922' }
  ]

  # books.sort_by! do |_, _, published|
  #   published <=> published
  # end

  books.sort_by! do |book|
    book[:published]
  end
  p books
end

def practice_problem3
  arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
  arr2 = [{ first: ['a', 'b', 'c'], second: ['d', 'e', 'f'] }, { third: ['g', 'h', 'i'] }]
  arr3 = [['abc'], ['def'], { third: ['ghi'] }]
  hsh1 = { 'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i'] }
  hsh2 = { first: { 'd' => 3 }, second: { 'e' => 2, 'f' => 1 }, third: { 'g' => 0 } }

  p arr1[2][1][3]
  p arr2[1][:third][0]
  p arr3[2][:third][0][0]
  p hsh1['b'][1]
  p hsh2[:third].key(0)
end

def practice_problem4
  arr1 = [1, [2, 3], 4]
  arr2 = [{ a: 1 }, { b: 2, c: [7, 6, 5], d: 4 }, 3]
  hsh1 = { first: [1, 2, [3]] }
  hsh2 = { ['a'] => { a: ['1', :two, 3], b: 4 }, 'b' => 5 }

  p arr1
  arr1[1][1] = 4
  p arr1
  p arr2
  arr2[2] = 4
  p arr2
  p hsh1
  hsh1[:first][2][0] = 4
  p hsh1
  p hsh2
  hsh2[['a']][:a][2] = 4
  p hsh2
end

def practice_problem5
  munsters = {
  'Herman' => { 'age' => 32, 'gender' => 'male' },
  'Lily' => { 'age' => 30, 'gender' => 'female' },
  'Grandpa' => { 'age' => 402, 'gender' => 'male' },
  'Eddie' => { 'age' => 10, 'gender' => 'male' },
  'Marilyn' => { 'age' => 23, 'gender' => 'female' }
  }

  # munsters.select! do |name, attr|
  #   attr['gender'] == 'male'
  # end

  # total_age = 0
  # munsters.each { |name, attr| total_age += attr['age']}
  # p total_age

  total_male_age = 0
  munsters.each_value do |details|
    total_male_age += details['age'] if details['gender'] == 'male'
  end
  p total_male_age
end

def practice_problem6
  munsters = {
  'Herman' => { 'age' => 32, 'gender' => 'male' },
  'Lily' => { 'age' => 30, 'gender' => 'female' },
  'Grandpa' => { 'age' => 402, 'gender' => 'male' },
  'Eddie' => { 'age' => 10, 'gender' => 'male' },
  'Marilyn' => { 'age' => 23, 'gender' => 'female' }
  }

  munsters.each do |name, attr|
    puts "#{name} is a #{attr['age']} year old #{attr['gender']}"
  end
end

def practice_problem8
  hsh = { first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog'] }

  # vowels = ['a', 'e', 'i', 'o', 'u']

  # hsh.each_value do |word|
  #   word.each do |word|
  #     word.chars.each do |letter|
  #       p letter if vowels.include? letter
  #     end
  #   end
  # end

  vowels = 'aeiou'

  hsh.each do |_, value|
    value.each do |str|
      str.chars.each do |char|
        puts char if vowels.include?(char)
      end
    end
  end
end

def practice_problem9
  arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
  # new_arr = arr.map { |sub| sub.sort }
  new_arr = arr.map(&:sort)
  p new_arr
end

practice_problem9
