#Methods
In programming, functions and methods are blocks of code referred to by a name.
Traditionally, methods are associated with (and called on) an object, functions are not.
Since Ruby is purely object-oriented, it technically has no functions, just methods

In Ruby, every method has a return value - it may be nil

A method that does not return anything may be used for just "side-effects"
A side-effect is some sort of modification to a non-local variable or other interaction.

puts and each are methods that are just used for side-effects
puts just prints its argument to the console, but returns nil
each passes an element of an array to a block, but returns the original array

#Objects
An object is a package of information and behavior
An Array is an object since it contains information (sequence of objects),
and behavior (can be sorted, accessed, etc.)

Every class inherits from the Object class
All classes have methods
"hello".upcase
3.times{puts "hello"}
(3.3).round

Every class inherits at least 2 methods (to_s and inspect)
inspect returns a string represeting a human-readable representation of an object
-really just a string representation of the object

class T
   def initialize(i)
      @i = i
   end
   def to_s
      @i.to_s
   end
end

t = T.new 42
puts t   => 42
p t      => #<T:0xb7ecc8b0 @i=42>

puts v. p
p calls inspect on its argument
puts calls to_s
-p is more commonly used for debugging, while puts is commonly used for displaying content to the user


nil
nil is returned from methods where there is no answer
[5, 4, 19].index(42)
=>nil

.nil? returns true if the argument is nil

#Arrays
Can create an array as follows:
sample_arr = Array.new
another_arr = [] #preferred way

Can access a subset of elements using a range
some_fruits = ["pear", "apple", "banana", "orange"]
some_fruits[1..3]
=>["apple", "banana", "orange"]

-1 can be used to access the end value, -2 second to last, etc.

-NOTE: do not modify an array while iterating through it:
array = [0, 1, 2, 3]
i = 0
while i < array.count
  array.delete_at(i)
  i += 1
end
This may seem to remove all elements in the array, but since the array
is modified with each iteration, it wont

Can modify arrays using << (shovel) or + (concat)
ret = []
ret << 10
ret << 20

ans = []
ans << "answer"

new_arr = ret + ans

NOTE: shovel does not create a new array, it modifies the existing one by appending an element
concat does however create a new array

-NOTE: Array.concat method is much faster than +
ret.concat(ans)
makes a copy of ans and appends it to ret
new_arr = ret + ans
makes a copy of both ret and ans, adds them together, and copies them
into the newly created new_arr object
-This is more noticable when one array is large, the other is small

push(<<)/pop
Using the shovel, we can use an array like a Stack (last in first out)
nums = []
nums << 1
nums << 2
nums << 3
nums.pop
=> 3
[1, 2]

shift allows an Array to act like a Queue (first in first out)
nums = []
nums << 1
nums << 2
nums << 3
nums.shift
=>1
[2, 3]

Check whether an array contains an item using include?
nums = [11, 13, 17]
nums.include?(10)
=>false

index() returns the position of the first occurence of an item
nums = [11, 13, 17]
nums.index(13)
=>1
nums.index(100)
=>nil

Can sort an array using sort
[3, 2, 1].sort
-note this will return a new array. To update the existing array, use sort!
-Methods without ! are considered "safe", while those with ! are considered "unsafe"

The sample method returns a random element from the array
die_faces = [1, 2, 3, 4, 5, 6]
roll1 = die_faces.sample
roll2 = die_faces.sample

#Strings
Double v. Single quote
When using double quotes, you can escape characters (backslash, quotes, etc.)
Cannot do this using single quotes, the string is printed as it appears

Interpolation - #{}
worst_date = "Monday"
"#{worst_date}s are the worst days"
-When using Interpolation, the expression inside #{}
is evaluated, converted to string, and then printed. 
Note this can only be used with double quotes, making double quotes an even better option

Can also use concatenation (+) to concat Strings
"I like " + chars

Substrings:
"this is my sentence"[5, 2]
=> "is"
5 is starting position, 2 is length
Can also use ranges like arrays

"this is my sentence"[5..6]
=> "is"

