#return the message
def echo(message)
	message
end

#return the message in all caps
def shout(message)
	message.upcase
end

#repeat the message num_repeat times
#the 2nd argument (number of times to repeat)
#is optional, default value is 2
def repeat(message, num_repeats=2)
	ret = ""
	num_repeats.times do |i|		
		ret << message + " "
	end

	#removes trailing space
	ret[0..-2]
end

#return the first "length" letters in word
def start_of_word(word, length)
	word[0, length]
end

#return the first word of a sentence
def first_word(sentence)
	sentence.split(" ").first
end

#Titelize the sentence
#do not capitalize "little" words (and, a, and, etc) if they are not the first word
def titleize(sentence)
	ret = ""
	words = sentence.split(" ")
	num_words = words.length

	#These are the words NOT to be capitalized if they are not the first word
	#The test case includes over as a little_word
	little_words = ["a", "an", "and", "the", "over"]

	words.each_with_index do |word, i|
		if(i > 0)
			if(little_words.include?(word))
				ret << word + " "
			else
				ret << word.capitalize + " "
			end
		else
			#capitalize the first word, regardless of if it is a little_word
			ret << word.capitalize + " "
		end
	end

	ret[0..-2]
end