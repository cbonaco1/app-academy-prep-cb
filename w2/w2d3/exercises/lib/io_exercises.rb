# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
	special_number = (1..100).to_a.shuffle.first

	won = false
	guess_count = 1

	until won
		puts "Please guess a number"
		guess = gets.chomp.to_i

		if(guess != special_number)	
			guess_count += 1
			puts "You guessed: #{guess}"
			if(guess < special_number)
				puts "too low"
			else
				puts "too high"
			end
		else
			puts "You guessed correctly!"
			puts "The number was #{special_number}"
			puts "It took you #{guess_count} guess(es)"
			won = true
		end
	end
end

def shuffle_file
	puts "Please enter a file in the current directory:"
	filename = gets.chomp
	lines_array = File.readlines(filename)
	lines_array.shuffle!

	File.open("#{filename}-shuffled.txt", "w") do |newfile|
		lines_array.each do |line|
			newfile.puts line
		end
	end
end