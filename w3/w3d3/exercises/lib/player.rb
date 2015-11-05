class HumanPlayer
	#This class is responsible for translating user input 
	#into positions of the form [x, y]
	def get_play
	    puts "Please enter a move in the form X Y (x-coordinate space y-coordinate)"
	    move = gets.chomp.split(" ")
	    move.map { |m| m.to_i  }
  	end
end

class ComputerPlayer
	#Computer player needs to know about
	#the board in order to generate a random fire position
	#HumanPlayer does not since we are entering the positions
	#to fire at manually
	attr_accessor :board
	def initialize(board_in)
		@board = board_in
	end

	def get_play
		#Generate a random position with a ship on it
		#Do not fire at a position that has already been fired 
		#(contains :x)
		random_x = rand(@board.length)
		random_y = rand(@board.length)
		until (@board[random_x, random_y] == :s)
			random_x = rand(@board.length)
			random_y = rand(@board.length)			
		end
		[random_x, random_y]
	end
end