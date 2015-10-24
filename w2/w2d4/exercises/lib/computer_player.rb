require_relative 'board'
class ComputerPlayer
	attr_accessor :mark, :name
	attr_reader :board

	def initialize(name)
		@name = name
	end

	def display(board)
		@board = board
	end

	#return a wining move if one is available, random otherwise
	def get_move
		if(row_winning_move)
			return row_winning_move
		end
		if(column_winning_move)
			return column_winning_move
		end
		if(left_diag_winning_move)
			return left_diag_winning_move
		end
		if(right_diag_winning_move)
			return right_diag_winning_move
		end

		[rand(3), rand(3)]
	end

	#check the rows of the grid
	#If the row has 2 of one mark (X or Y),
	#and one nil value, retun the index of the nil value
	def row_winning_move
		@board.grid.each_with_index do |row, r|
			other_nil_index = contains_two_marks(row)
			if(other_nil_index)
				return [r, other_nil_index]
			end
		end
		return false
	end

	def column_winning_move
		column = 0
		while (column < @board.grid.length)
			row = 0
			column_values = []
			while (row < @board.grid.length)
				column_values << @board.grid[row][column]
				row += 1
			end
			
			other_nil_index = contains_two_marks(column_values)
			if(other_nil_index)
				return [other_nil_index, column]
			end
			column += 1
		end
		return false
	end

	def left_diag_winning_move
		row = 0
		column = 0
		left_diag_values = []
		while ( (row < @board.grid.length) && (column < @board.grid.length) )
			left_diag_values << @board.grid[row][column]
			row += 1
			column += 1
		end
		
		other_nil_index = contains_two_marks(left_diag_values)
		if(other_nil_index)
			return [other_nil_index, other_nil_index]
		else
			return false
		end
	end

	def right_diag_winning_move
		row = 0
		column = @board.grid.length - 1
		right_diag_values = []
		while (row < @board.grid.length)
			right_diag_values << @board.grid[row][column]
			row += 1
			column -= 1
		end
		
		other_nil_index = contains_two_marks(right_diag_values)
		if(other_nil_index)
			case other_nil_index
			when 0
				return [other_nil_index, 2]
			when 1
				return [1, 1]
			when 2
				return [2, 0]
			else
				return false
			end
		end
	end

	#Take in array, see if the array contains 2 X or 2 Os
	#If so, return the position of the other value if nil
	def contains_two_marks(values)
		if( (values.count(:X) == 2) || (values.count(:O) == 2) )
			if(values.include?(nil))
				return values.index(nil)
			end
		end
		return false
	end

end
