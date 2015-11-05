# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
	attr_reader :towers
	def initialize
		@towers = [(1..3).to_a.reverse, [], []]
	end

	def play
		until won?

			#prompt user what pile to select from
			#this is the index of a tower in towers array
			puts "Enter tower to move FROM: "
			from_tower = gets.chomp.to_i

			#prompt user which tower to move to
			puts "Enter tower to move TO: "
			to_tower = gets.chomp.to_i		

			#determine if move is valid
			if(valid_move?(from_tower, to_tower))
				move(from_tower, to_tower)
				puts "Move completed"
			else
				puts "Invalid move, please enter again"
			end
			
		end
		puts "You won!"

	end

	def render
	end

	#condition when game is over
	#end if all discs are in another pile
	def won?
		towers[1..2].any?{|tower| tower.length == 3}
	end

	def valid_move?(from_tower, to_tower)
		#check if from_tower has any disks to move
		#cant move if there are no disks
		if(towers[from_tower].length == 0)
			return false
		end

		#check the disk on top of the to_tower
		#is not less than the disk to be moved
		disk_to_move = towers[from_tower].last
		disk_to_top = towers[to_tower].last

		# disk_to_top could be nil (empty)
		if(disk_to_top.nil?)
			return true
		end

		if(disk_to_top < disk_to_move)
			return false
		end

		true
	end

	def move(from_tower, to_tower)
		disk_to_move = towers[from_tower].pop
		towers[to_tower] << disk_to_move		
	end
end

TowersOfHanoi.new.play