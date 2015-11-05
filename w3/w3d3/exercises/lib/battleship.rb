require_relative 'board.rb'
require_relative 'player.rb'

class BattleshipGame
  attr_reader :board, :player

  def initialize(player_in, board_in)
  	@player = player_in
    @board = board_in
  end

  def attack(position)
    @board.place_mark(position)
  end

  def count
  	@board.count
  end

  def game_over?
  	@board.won?
  end

  def play
    @board.populate_grid
    until @board.won?
      play_turn
    end
  end

  def play_turn
    move = @player.get_play
    puts "Move: #{move}"
    attack(move)
    display_status
    rescue Exception => e
      puts "#{e}"
      retry
  end

  def display_status
    puts "---Current game status---"
    @board.display
    print "\n"
    puts "Number of ships remaining: #{@board.count}"
    puts "--------------------------"
  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new(Array.new(3) { Array.new(3) })
  human_player = HumanPlayer.new
  pc = ComputerPlayer.new(board)
  game = BattleshipGame.new(pc, board)
  game.play
end