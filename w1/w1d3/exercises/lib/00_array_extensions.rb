# Sum
#
# Write an Array method, `sum`, that returns the sum of the elements in the
# array. You may assume that all of the elements are integers.

class Array
  def sum
    self.inject(0){|sum, num| sum + num}
  end
end

# Square
#
# Write an array method, `square`, that returns a new array containing the
# squares of each element. You should also implement a "bang!" version of this
# method, which mutates the original array.

class Array
  #Modifies the original by iterating through all elements
  #and manually re-setting each element at their index
  def square!
    self.each_with_index do |num, index|
      self[index] = num**2
    end
  end

  #map does not modify the receiver
  def square
    self.map{|num| num**2 }
  end
end

# Finding Uniques
#
# Monkey-patch the Array class with your own `uniq` method, called
# `my_uniq`. The method should return the unique elements, in the order
# they first appeared:
#
# ```ruby
# [1, 2, 1, 3, 3].my_uniq # => [1, 2, 3]
# ```
#
# Do not use the built-in `uniq` method!

class Array
  def my_uniq
    ret = []
    self.each do |item|
      unless (ret.include?(item))
        ret << item
      end
    end
    ret
  end
end

# Two Sum
#
# Write a new `Array#two_sum` method that finds all pairs of positions
# where the elements at those positions sum to zero.
#
# NB: ordering matters. I want each of the pairs to be sorted smaller
# index before bigger index. I want the array of pairs to be sorted
# "dictionary-wise":
#
# ```ruby
# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
# ```
#
# * `[0, 2]` before `[1, 2]` (smaller first elements come first)
# * `[0, 1]` before `[0, 2]` (then smaller second elements come first)

class Array
  def two_sum
    ret = []
    i = 0
    while(i < self.length)
      j = i + 1
      while (j < self.length)
        if(self[i] + self[j] == 0)
          ret << [i, j]
        end
        j+=1  
      end
      i+=1
    end
    ret
  end
end

# Median
#
# Write a method that finds the median of a given array of integers. If
# the array has an odd number of integers, return the middle item from the
# sorted array. If the array has an even number of integers, return the
# average of the middle two items from the sorted array.

class Array
  def median
    self.sort!
    mid_1 = (self.length / 2)
    ret = nil
    if(self.length > 0)
      if(self.length % 2 == 0)
        mid_2 = mid_1 - 1
        ret = (self[mid_1] + self[mid_2]) / 2.0
      else
        ret = self[mid_1]
      end      
    end
    ret
  end
end

# My Transpose
#
# To represent a *matrix*, or two-dimensional grid of numbers, we can
# write an array containing arrays which represent rows:
#
# ```ruby
# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]
#
# row1 = rows[0]
# row2 = rows[1]
# row3 = rows[2]
# ```
#
# We could equivalently have stored the matrix as an array of
# columns:
#
# ```ruby
# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]
# ```
#
# Write a method, `my_transpose`, which will convert between the
# row-oriented and column-oriented representations. You may assume square
# matrices for simplicity's sake. Usage will look like the following:
#
# ```ruby
# matrix = [
#   [0, 1, 2],
#   [3, 4, 5],
#   [6, 7, 8]
# ]
#
# matrix.my_transpose
#  # => [[0, 3, 6],
#  #    [1, 4, 7],
#  #    [2, 5, 8]]
# ```
#
# Don't use the built-in `transpose` method!

class Array
  #This method implements the bonus of using a non-square matrix
  def my_transpose
    ret = []

    #Determine the length of the longest row in the matrix
    #This is used as the limit for the column index counter
    max_row_length = 0
    self.each do |array|
      if(array.length > max_row_length)
        max_row_length = array.length
      end
    end

    col = 0
    #column count goes up to the size of the largest row
    while (col < max_row_length)
      row = 0
      ans_row = []
      while (row < self.length)
        val = self[row][col]
        if(val)
          ans_row << val
        else
          #add nil to the returned array if there is no value at the index
          ans_row << nil
        end
        row+=1
      end
      ret << ans_row
      col+=1
    end
    ret
  end  
end

# Bonus: Refactor your `Array#my_transpose` method to work with any rectangular
# matrix (not necessarily a square one).
# Completed using the following example:
args = [
    [1, 2, 3],
    [4, 5],
    [6, 7, 8, 9]
]
#args.my_transpose returns
#[1, 4, 6],
#[2, 5, 7],
#[3, nil, 8],
#[nil, nil, 9]
#My answer to the bonus places nil in places there may be a row, but no column (and vice versa)