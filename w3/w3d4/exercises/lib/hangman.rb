class Hangman
  attr_reader :guesser, :referee, :board

  def initialize(players={})
  	@guesser = players[:guesser]
  	@referee = players[:referee]
  	@board = []
  end

  def play
  	setup
  	until game_over?
  		take_turn
  	end
  end

  def setup
  	secret_word_length = @referee.pick_secret_word
  	@guesser.register_secret_length(secret_word_length)
  	secret_word_length.times do
  		@board << nil
  	end
  end

  def take_turn
  	guessers_guess = @guesser.guess(@board)
  	puts "Guess is: #{guessers_guess}"
  	matches = @referee.check_guess(guessers_guess)
  	@guesser.handle_response(guessers_guess, matches)
  	update_board(matches, guessers_guess)
  	print_board
  end

  def game_over?
  	@board.index(nil).nil?
  end

  def update_board(matches, guess)
  	unless matches.empty?
  		matches.each do |match|
  			board[match] = guess
  		end
  	end
  end

  def print_board
  	print "Board: "
  	@board.each do |letter|
  		print letter
  	end
  	print "\n"
  end

end

class HumanPlayer

	def pick_secret_word
		puts "Enter the length of the secret word: "
		gets.chomp.to_i
	end

	def guess(board)
		puts "Please enter a letter to guess"
		gets.chomp
	end

	#Tell the computer where the guessed letter occurs in secret_word
	def check_guess(letter)
		puts "Please enter the correct positions where the guess occurs"
		matches = gets.chomp.split(" ")
		matches.map { |match| match.to_i  }
	end

	def handle_response(guessers_guess, matches) 
	end

	def register_secret_length(secret_word_length)
	end	
end

class ComputerPlayer
	attr_accessor :dictionary, :candidate_words
	attr_writer :secret_word

	def initialize(dictionary_in)
		@dictionary = dictionary_in
		@candidate_words = @dictionary
		@secret_word = @dictionary.sample
	end

	#Returns the length of the secrect word
	def pick_secret_word
		@secret_word.length
	end

	def guess(board)
		#An array of all the letters in candidate_words
		candidate_letters = @candidate_words.join("").split("").sort
		if(board.count(nil) == board.length)
			#Return most common letter in candidate words.
			return get_most_used_letter(candidate_letters)
		else
			#Return most common letter used aside from ones already known
			#Remove the letters in board from letters in candidate_words
			board.each do |board_letter|
				candidate_letters.delete(board_letter)
			end
			#get the most repeated letter after ones in board are removed
			return get_most_used_letter(candidate_letters)
		end
	end	

	#Note: word is an array of letters
	def get_most_used_letter(word)
		letter_counts = Hash.new(0)
		word.each do |letter|
			letter_counts[letter] += 1
		end

		max_letter = ""
		max_letter_count = 0
		letter_counts.each do |letter, count| 
			if(count > max_letter_count)
				max_letter_count = count
				max_letter = letter
			end
		end

		max_letter		
	end

	#Returns indices of the found letter in an array
	#If no matches found, it returns an empty array
	def check_guess(letter)
		ret = []
		if(@secret_word.include?(letter))
			@secret_word.split("").each_with_index do |let, i|
				if(let == letter)
					ret << i
				end
			end
		end
		ret
	end

	def register_secret_length(secret_word_length)
		#filter words from the candidate_words that are secret_word_length
		@candidate_words = @candidate_words.select do |word| 
			word.length == secret_word_length 
		end
	end

	#Filter candidate_words based on response from guess
	def handle_response(guessers_guess, matching_indices)
		if(matching_indices.empty?)
			@candidate_words.delete_if {|word| word.include?(guessers_guess)}
		else
			@candidate_words = @candidate_words.select do |word| 
				contain_match_at_indices(word, matching_indices, guessers_guess)
			end
		end
	end	

	#return true if word contains guess at ONLY the values in the indices array
	def contain_match_at_indices(word, indices, guess)
		#Set secret_word to word from candidate_words
		#so we can use ComputerPlayer#check_guess method
		@secret_word = word
		matching_indices = check_guess(guess)
		(indices == matching_indices) ? true : false		
	end
end

if __FILE__ == $PROGRAM_NAME
	dictionary = File.readlines("dictionary.txt")
	#readlines adds a \n character to each word
	#This throws off the length of the word, which is used in game
	dictionary = dictionary.map { |word| word.chomp  }


	words = ["reel","keel","meet", "hello", "bye", "hell", "llama"]

	pc_player = ComputerPlayer.new(dictionary)
	#pc_player.register_secret_length(4)
	#board = [nil, "e", "e", nil]
	#puts pc_player.guess(board)

	human_player = HumanPlayer.new
	players = {guesser: human_player, referee: pc_player}
	game = Hangman.new(players)

	#puts "Secret word: #{pc_guesser.secret_word}, #{pc_guesser.pick_secret_word}"
	#puts "#{pc_guesser.secret_word.split("")}"
	game.play
end