class Board
	attr_accessor :grid

	def initialize(grid_in=Board.default_grid)	
		@grid = grid_in
	end

	#Default size of grid is 10x10
	def self.default_grid
		Array.new(10) { Array.new(10) }
	end

	#Adding syntactic sugar in order to access points in grid easier
	#def [](row, col)
	#	@grid[row][col]
	#end
	def [](points)
		@grid[points[0]][points[1]]
	end

	def []=(position, mark)
		@grid[position[0]][position[1]] = mark
	end

	def length
		self.grid.length
	end

	def display
		@grid.each do |row|
			row.each do |ship|
				print "| #{ship} "
			end
			print "| \n"
		end
	end

	#Returns number of valid targets(ships) 
	#remaining on a grid
	def count
		ship_count = 0
		self.grid.each do |row|
			ship_count += row.count(:s)
		end
		ship_count		
	end

	#Returns true if the position is empty
	#meaning its value in grid is nil
	#If no position given, check if grid contains any ships
	def empty?(position=nil)
		if (position)
			self[position].nil?
		else
			(self.count > 0) ? false : true
		end
	end

	def place_mark(position)
		if( (self[position] == :s) || (self[position].nil?) )
			self[position] = :x
		else
			raise "This position is already marked!"
		end
	end

	#Assume here that the board is square (same num of rows and cols)
	#If row is squre and board is full, 
	#then number of ships equals (rows * rows)
	def full?
		grid_size = self.length
		expected_ship_count = grid_size * grid_size
		actual_ship_count = self.count
		(expected_ship_count != actual_ship_count) ? false : true
	end

	def place_random_ship
		if (self.full?)
			raise "The board is full!"	
		else
			x, y = get_random_position
			self.grid[x][y] = :s			
		end
	end

	def get_random_position
		#Come up with random position to place a ship
		#If generated random coordinates are already taken,
		#get more until they are not
		x = rand(self.grid.length)
		y = rand(self.grid.length)

		#Keep getting x's and y's until
		#you get a spot which is empty
		until (self.empty?([x, y]))
			x = rand(self.grid.length)
			y = rand(self.grid.length)
		end
		puts "Returning: X:#{x}, Y:#{y}"
		[x, y]			
	end

	def won?
		(self.count > 0) ? false : true
	end

	#Randomly distributes ships across the grid
	def populate_grid
		until (self.full?)
			place_random_ship
		end
		puts "Grid is full"
	end

	#Returns if a position hits a ship
	def in_range?(pos)
	end

end