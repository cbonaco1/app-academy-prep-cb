class Board
	attr_accessor :grid
	def initialize(grid=nil)
		if(grid.nil?)
			@grid = Array.new(3) { Array.new(3) }
		else
			@grid = grid
		end
	end

	def place_mark(position, mark)
		row = position[0]
		column = position[1]
		if (@grid[row][column].nil?)
			@grid[row][column] = mark
		else
			raise "This position is already marked!"
		end
	end

	def empty?(position)
		row = position[0]
		column = position[1]
		@grid[row][column].nil?
	end

	#Helper method to check if the entire board is empty
	def empty_board?
		@grid.each do |row|
			if((row.include?(:X)) || (row.include?(:O)))
				return false
			end
		end
		return true
	end

	#Helper method to check if the board is completely filled
	#with marks (doesnt contain nil)
	def full_board?
		@grid.each do |row|
			if(row.include?(nil))
				return false
			end
		end
		return true
	end

	#Helper method to determine if game is tied
	#Game is tied if there is a full board, and no winning move
	def game_tied?
		if( (full_board?) && (winner.nil?) )
			return true
		else
			return false
		end		
	end

	#Check if game is over based on the following:
	#Return false if board is empty
	#Return true if there is a winning move
	#Returns true if game is tied (no empty cells and no winning moves) 
	#Return false if board is in progress
	def over?
		if(empty_board?)
			return false
		end
		
		if(winner || game_tied?)
			return true
		end	

		if(winner == nil)
			return false
		end		

		if(!empty_board?)
			return false
		end		
	end

	#check for different winning possibilities
	#If none win, return nil
	def winner
		if(check_rows)
			return check_rows
		end

		if(check_columns)
			return check_columns
		end

		if(check_left_diag)
			return check_left_diag
		end

		if(check_right_diag)
			return check_right_diag
		end	

		return nil
	end	

	#Below are helper methods which check for winners
	#Can either win by rows, column, or left/right diagnol

	#Look at each row and determine if it has one repeating, non-nil value
	def check_rows
		@grid.each do |row|
			unless(row.include?(nil))
				if(row.uniq.length == 1)
					return row.uniq.first
				end
			end
		end
		return nil
	end

	#Put all the values for a column into an array
	#If the array contains one repeating, non-nil value, 
	#then there is a winner
	def check_columns
		column = 0
		while (column < @grid.length)
			row = 0
			column_values = []
			while (row < @grid.length)
				column_values << @grid[row][column]
				row += 1
			end
			unless (column_values.include?(nil))
				if(column_values.uniq.length == 1)
					return column_values.uniq.first
				end				
			end
			column += 1
		end
		return nil
	end

	#Looks at top left mark, then going down diagnolly,
	#compare each value to the top_left
	def check_left_diag
		unless (empty?([0, 0]))
			top_left = @grid[0][0]
			i = 1
			while (i < @grid.length)
				if(@grid[i][i] != top_left)
					break
				elsif (i == @grid.length - 1)
					return top_left
				end
				i += 1
			end
		end
		return nil
	end

	#Looks at the top right mark, then going down diagnolly,
	#compare each value to the top right
	def check_right_diag
		unless (empty?([0, @grid.length - 1]))
			top_right = @grid[0][@grid.length - 1]
			column = @grid.length - 2
			row = 1
			while (column >= 0)
				if(@grid[row][column] != top_right)
					break
				elsif (row == @grid.length - 1)
						return top_right
				end
				row += 1
				column -= 1
			end			
		end
		return nil		
	end

end