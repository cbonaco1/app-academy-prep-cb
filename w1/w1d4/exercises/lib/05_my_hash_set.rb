# MyHashSet
#
# Ruby provides a class named `Set`. A set is an unordered collection of
# values with no duplicates.  You can read all about it in the documentation:
#
# http://www.ruby-doc.org/stdlib-2.1.2/libdoc/set/rdoc/Set.html
#
# Let's write a class named `MyHashSet` that will implement some of the
# functionality of a set. Our `MyHashSet` class will utilize a Ruby hash to keep
# track of which elements are in the set.  Feel free to use any of the Ruby
# `Hash` methods within your `MyHashSet` methods.
#
# Write a `MyHashSet#initialize` method which sets an empty hash object to
# `@store`. Next, write an `#insert(el)` method that stores `el` as a key
# in `@store`, storing `true` as the value. Write an `#include?(el)`
# method that sees if `el` has previously been `insert`ed by checking the
# `@store`; return `true` or `false`.
#
# Next, write a `#delete(el)` method to remove an item from the set.
# Return `true` if the item had been in the set, else return `false`.  Add
# a method `#to_a` which returns an array of the items in the set.
#
# Next, write a method `set1#union(set2)` which returns a new set which
# includes all the elements in `set1` or `set2` (or both). Write a
# `set1#intersect(set2)` method that returns a new set which includes only
# those elements that are in both `set1` and `set2`.
#
# Write a `set1#minus(set2)` method which returns a new set which includes
# all the items of `set1` that aren't in `set2`.

class MyHashSet
	attr_accessor :store
	def initialize
		@store = {}
	end

	def insert(el)
		@store[el] = true
	end

	def include?(el)
		@store.keys.include?(el) ? true : false
	end

	def delete(el)
		if(self.include?(el))
			#delete the element and return true
			@store.delete(el)
			return true
		else
			return false
		end
	end

	def to_a
		@store.keys
	end

	#Return a new MyHashSet object which includes all elements 
	#from set1, and all elements from set2
	def union(set2)
		ret = MyHashSet.new
		elements = (self.to_a + set2.to_a).uniq
		elements.each do |el|
			ret.insert(el)
		end
		ret
	end	

	# returns a new MyHashSet object which includes only
	# those elements that are in both `set1` and `set2`.
	def intersect(set2)
		ret = MyHashSet.new
		elements = self.to_a + set2.to_a
		repeated_elements = elements.select{|el| elements.count(el) > 1}
		repeated_elements.each do |el|
			unless ret.include?(el)
				ret.insert(el)
			end
		end
		ret
	end

	# returns a new MyHashSet object which includes
	# all the items of `set1` that aren't in `set2`.
	def minus(set2)
		ret = MyHashSet.new
		self.store.each do |el, value|
			unless(set2.include?(el))
				ret.insert(el)
			end
		end
		ret
	end
	
	#Bonus question
	#return the elements contained in either `set1` or `set2`, but not both
	def symmetric_difference(set2)
		ret = MyHashSet.new
		elements = self.to_a + set2.to_a
		#combine the keys and see which keys only appear once in the combined set
		single_elements = elements.select{|el| elements.count(el) == 1}
		single_elements.each do |el|
			unless (ret.include?(el))
				ret.insert(el)
			end
		end
		ret
	end

	#Bonus question
	# return true if `object` is a `MyHashSet`, 
	# has the same size as `set1`, and every member of
	# `object` is a member of `set1`.
	def ==(object)
		ret = true
		unless(object.is_a?(MyHashSet))
			return false
		else
			ret = (self.to_a == object.to_a) ? true : false
		end
		ret
	end
end

#Test cases for the first bonus
set1 = MyHashSet.new
set1.insert("Mark Hamill")
set1.insert("Natalie Portman")
set1.insert("Anthony Daniels")
set1.insert("C3PO")

set2 = MyHashSet.new
set2.insert("Natalie Portman")
set1.insert("Harrison Ford")
set2.insert("Anthony Daniels")
set2.insert("R2D2")

difference = MyHashSet.new
difference = set1.symmetric_difference(set2)
#=>["Mark Hamill", "C3P0", "Harrison Ford", "R2D2"]

#Test cases for the second bonus
set3 = MyHashSet.new
set3.insert(10)
set3.insert(20)
set3.insert(30)
set3.insert(40)

set4 = MyHashSet.new
set4.insert("Mark Hamill")
set4.insert("Harrison Ford")

set5 = MyHashSet.new
set5.insert(10)
set5.insert(20)
set5.insert(30)
set5.insert(40)

set6 = {"name"=>"Christian", "age"=>26}

set3 == set4
#=>false
set3 == set5
#=>true
set6 == set3
#=>false


# Bonus
#
# - Write a `set1#symmetric_difference(set2)` method; it should return the
#   elements contained in either `set1` or `set2`, but not both!
# - Write a `set1#==(object)` method. It should return true if `object` is
#   a `MyHashSet`, has the same size as `set1`, and every member of
#   `object` is a member of `set1`.
