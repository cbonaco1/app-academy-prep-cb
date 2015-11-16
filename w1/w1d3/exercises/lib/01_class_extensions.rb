# String: Caesar cipher
#
# * Implement a Caesar cipher: http://en.wikipedia.org/wiki/Caesar_cipher
#
# Example:
#   `"hello".caesar(3) # => "khoor"`
#
# * Assume the text is all lower case letters.
# * You'll probably want to map letters to numbers (so you can shift
#   them). You could do this mapping yourself, but you will want to use
#   the [ASCII codes][wiki-ascii], which are accessible through
#   `String#ord` or `String#each_byte`. To convert back from an ASCII code
#   number to a character, use `Fixnum#chr`.
# * Important point: ASCII codes are all consecutive!
#     * In particular, `"b".ord - "a".ord == 1`.
# * Lastly, be careful of the letters at the end of the alphabet, like
#   `"z"`! Ex.: `caesar("zany", 2) # => "bcpa"`

class String
  def caesar(shift)
  	ret = ""
  	letters = self.split("")
  	letters.each do |letter|
  		asci = letter.ord
      #only add the shift to letters (no symbols)
      if( (asci >= 97) && (asci <= 122) )
    		new_asci = asci + shift
    		if(new_asci > 122)
    			new_asci = (new_asci - 122) + 96
    		end
    		new_letter = new_asci.chr
    		ret << new_letter
      else
        ret << letter
      end
  	end
  	ret
  end
end

# Hash: Difference
#
# Write a method, `Hash#difference(other_hash)`. Your method should return
# a new hash containing only the keys that appear in one or the other of
# the hashes (but not both!) Thus:
#
# ```ruby
# hash_one = { a: "alpha", b: "beta" }
# hash_two = { b: "bravo", c: "charlie" }
# hash_one.difference(hash_two)
#  # => { a: "alpha", c: "charlie" }
# ```

class Hash
  def difference(other_hash)
    #Returned hash should contain key-values that are in one hash but not the other
  	ret = {}
  	hash_one_keys = self.keys
  	hash_two_keys = other_hash.keys

  	unique_hash_one_keys = get_unique_keys(hash_one_keys, hash_two_keys)
  	unique_hash_two_keys = get_unique_keys(hash_two_keys, hash_one_keys)
  	#Cant combine these arrays since you need to know which 
  	#hashes they belong to in order to get the value at that key

  	#Iterate through each hash, adding the unique ones to ret
  	unique_hash_one_keys.each do |key|
  		ret[key] = self[key]
  	end
  	unique_hash_two_keys.each do |key|
  		ret[key] = other_hash[key]
  	end  
  	
  	ret	
  end

  #get the keys in hash_keys that are not in other_hash_keys
  def get_unique_keys(hash_keys, other_hash_keys)
  	unique_keys = []
  	hash_keys.each do |key|
  		unless (other_hash_keys.include?(key))
  			unique_keys << key
  		end
  	end 
  	unique_keys 	
  end
end

# Stringify
#
# In this exercise, you will define a method `Fixnum#stringify(base)`,
# which will return a string representing the original integer in a
# different base (up to base 16). **Do not use the built-in
# `#to_s(base)`**.
#
# To refresh your memory, a few common base systems:
#
# |Base 10 (decimal)     |0   |1   |2   |3   |....|9   |10  |11  |12  |13  |14  |15  |
# |----------------------|----|----|----|----|----|----|----|----|----|----|----|----|
# |Base 2 (binary)       |0   |1   |10  |11  |....|1001|1010|1011|1100|1101|1110|1111|
# |Base 16 (hexadecimal) |0   |1   |2   |3   |....|9   |A   |B   |C   |D   |E   |F   |
#
# Examples of strings your method should produce:
#
# ```ruby
# 5.stringify(10) #=> "5"
# 5.stringify(2)  #=> "101"
# 5.stringify(16) #=> "5"
#
# 234.stringify(10) #=> "234"
# 234.stringify(2)  #=> "11101010"
# 234.stringify(16) #=> "EA"
# ```
#
# Here's a more concrete example of how your method might arrive at the
# conversions above:
#
# ```ruby
# 234.stringify(10) #=> "234"
# (234 / 1)   % 10  #=> 4
# (234 / 10)  % 10  #=> 3
# (234 / 100) % 10  #=> 2
#                       ^
#
# 234.stringify(2) #=> "11101010"
# (234 / 1)   % 2  #=> 0
# (234 / 2)   % 2  #=> 1
# (234 / 4)   % 2  #=> 0
# (234 / 8)   % 2  #=> 1
# (234 / 16)  % 2  #=> 0
# (234 / 32)  % 2  #=> 1
# (234 / 64)  % 2  #=> 1
# (234 / 128) % 2  #=> 1
#                      ^
# ```
#
# The general idea is to each time divide by a greater power of `base`
# and then mod the result by `base` to get the next digit. Continue until
# `num / (base ** pow) == 0`.
#
# You'll get each digit as a number; you need to turn it into a
# character. Make a `Hash` where the keys are digit numbers (up to and
# including 15) and the values are the characters to use (up to and
# including `F`).

class Fixnum
  def stringify(base)
    #this hash contain the string values of all digits from 0-15 (use a-f for 10-15)
    #the values from this hash are used to build the answer
    num_codes = {
      0 => "0",
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9",
      10 => "a",
      11 => "b",
      12 => "c",
      13 => "d",
      14 => "e",
      15 => "f"
    }

    ret = ""
    div = 1
    while (div <= self)
      ans = (self / div) % base
      ret << num_codes[ans]
      div = div * base
    end
    ret.reverse
  end
end

# Bonus: Refactor your `String#caesar` method to work with strings containing
# both upper- and lowercase letters.
