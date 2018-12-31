require "byebug"
# EASY

# Define a method that, given a sentence, returns a hash of each of the words as
# keys with their lengths as values. Assume the argument lacks punctuation.
def word_lengths(str)
  hash = {}
  str.split.each {|word| hash[word] = word.length}
  return hash
end

# Define a method that, given a hash with integers as values, returns the key
# with the largest value.
def greatest_key_by_val(hash)
  hash.sort_by {|k,v| v}[-1][0]
end

# Define a method that accepts two hashes as arguments: an older inventory and a
# newer one. The method should update keys in the older inventory with values
# from the newer one as well as add new key-value pairs to the older inventory.
# The method should return the older inventory as a result. march = {rubies: 10,
# emeralds: 14, diamonds: 2} april = {emeralds: 27, moonstones: 5}
# update_inventory(march, april) => {rubies: 10, emeralds: 27, diamonds: 2,
# moonstones: 5}
def update_inventory(older, newer)
  newer.each {|k,v| older[k] = v}
  return older
end

# Define a method that, given a word, returns a hash with the letters in the
# word as keys and the frequencies of the letters as values.
def letter_counts(word)
  hash = {}
  word.each_char do |char|
    if hash[char]
      hash[char] += 1
    else
      hash[char] = 1
    end
  end
  return hash
end

# MEDIUM

# Define a method that, given an array, returns that array without duplicates.
# Use a hash! Don't use the uniq method.
def my_uniq(arr)
  #debugger
  hash = Hash.new(0)
  arr.each do |el|
    hash[el] = nil unless hash.has_key?(el)
  end
  return hash.keys
end

# Define a method that, given an array of numbers, returns a hash with "even"
# and "odd" as keys and the frequency of each parity as values.
def evens_and_odds(numbers)
  hash = {
    even: 0,
    odd: 0
  }

  numbers.each do |num|
    if num.even?
      hash[:even] += 1
    else
      hash[:odd] += 1
    end
  end
  return hash
end

# Define a method that, given a string, returns the most common vowel. Do
# not worry about ordering in the case of a tie. Assume all letters are
# lower case.
def most_common_vowel(string)
  vowels = {
    "u"=> 0,
    "o"=> 0,
    "i"=> 0,
    "e"=> 0,
    "a"=> 0
  }

  string.each_char do |char|
    if vowels.has_key?(char)
      vowels[char] += 1
    end
  end

  return vowels.sort_by {|k,v| v}[-1][0]
end

# HARD

# Define a method that, given a hash with keys as student names and values as
# their birthday months (numerically, e.g., 1 corresponds to January), returns
# every combination of students whose birthdays fall in the second half of the
# year (months 7-12). students_with_birthdays = { "Asher" => 6, "Bertie" => 11,
# "Dottie" => 8, "Warren" => 9 }
# fall_and_winter_birthdays(students_with_birthdays) => [ ["Bertie", "Dottie"],
# ["Bertie", "Warren"], ["Dottie", "Warren"] ]
def fall_and_winter_birthdays(students)
  fall_bdays = students.select {|k,v| v > 6}
  permutations(fall_bdays.keys)
end

def permutations(arr)
  perms = []
  arr.each_with_index do |el,idx|
    ((idx + 1)..(arr.length - 1)).each do |jdx|
      perms << [el, arr[jdx]]
    end
  end
  return perms
end
# Define a method that, given an array of specimens, returns the biodiversity
# index as defined by the following formula: number_of_species**2 *
# smallest_population_size / largest_population_size biodiversity_index(["cat",
# "cat", "cat"]) => 1 biodiversity_index(["cat", "leopard-spotted ferret",
# "dog"]) => 9
def biodiversity_index(specimens)
  spec_freq = {}
  specimens.each do |species|
    if spec_freq[species]
      spec_freq[species] += 1
    else
      spec_freq[species] = 1
    end
  end

  number_of_species = spec_freq.keys.length
  smallest_population_size = spec_freq.values.min
  largest_population_size = spec_freq.values.max

  return number_of_species**2 * smallest_population_size / largest_population_size
end

# Define a method that, given the string of a respectable business sign, returns
# a boolean indicating whether pranksters can make a given vandalized string
# using the available letters. Ignore capitalization and punctuation.
# can_tweak_sign("We're having a yellow ferret sale for a good cause over at the
# pet shop!", "Leopard ferrets forever yo") => true
def can_tweak_sign?(normal_sign, vandalized_sign)
  van_freq = character_count(vandalized_sign)
  nom_freq = character_count(normal_sign)

  van_freq.each do |letter, freq|
    #debugger
    if van_freq[letter] > nom_freq[letter]
      return false
    end
  end
  return true
end

def character_count(str)
  char_freq = Hash.new(0)
  clean_str = str.downcase.delete(" ,.:;!?")
  clean_str.each_char do |char|
    if char_freq[char]
      char_freq[char] += 1
    else
      char_freq[char] = 1
    end
  end
  return char_freq
end
