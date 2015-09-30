#Converts a sentence to pig latin based on the following rules:
# Rule 1: If a word begins with a vowel sound, add an "ay" sound to
# the end of the word.
#
# Rule 2: If a word begins with a consonant sound, move it to the end
# of the word, and then add an "ay" sound to the end of the word.
def translate(sentence)
	words = sentence.split(" ")
	vowels = ["a", "e", "i", "o"]
	ret = ""

	words.each do |word|
		consonants = ""
		letters = word.split("")
		letters.each_with_index do |letter, i|
			unless(vowels.include?(letter))
				consonants << letter
			else
				substring = word[i..-1]
				substring << consonants
				substring << "ay"

				ret << substring + " "
				break
			end
		end
	end
	#removes trailing space
	ret[0..-2]
end