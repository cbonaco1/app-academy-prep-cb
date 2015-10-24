class HumanPlayer
	attr_accessor :name

	def initialize(name)
		@name = name
	end

	#allow the play to enter a move of the form '0, 0',
	#and return it is [0, 0]
	def get_move
		puts "Enter where you would like to mark in the form (X, Y): "
		move = gets.chomp
		positions = move.split(", ")
		[positions[0].to_i, positions[1].to_i]
	end

	def display(board)
		board.grid.each_with_index do |row, r|
			print "| "
			row.each_with_index do |column, c|
				print "#{board.grid[r][c]} | "
			end
			print "\n"
		end
	end
end