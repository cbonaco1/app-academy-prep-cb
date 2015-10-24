require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
	attr_accessor :player_one, :player_two, :board, :current_player
	def initialize(playerOne, playerTwo)
		@player_one = playerOne
		@player_two = playerTwo
		@board = Board.new
		@current_player = @player_one
	end

	def switch_players!
		if (@current_player == @player_one)
			@current_player = @player_two
		else
			@current_player = @player_one
		end
	end

	def play_turn
		position = @current_player.get_move
		#Not sure how to get the mark the user wants at the position
		#Hard-coding it to :X
		board.place_mark(position, :X)
		switch_players!
	end

	def play
		until (@board.over?)
			play_turn
		end
	end
end
