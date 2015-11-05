#Reverses the string returned by the default block
def reverser
	if block_given?
		ret = ""
		words = yield.split(" ")
		words.each do |word| 
			ret << word.reverse + " "
		end	
	end
	ret.strip
end

#Adds a value to the value in the default block
#default number to add is 1
def adder(to_add=1)
	if block_given?
		yield + to_add
	end
end

#Executes the default block run_block times
#Default times to run the block is 1
def repeater(run_block=1)
	if block_given?
		run_block.times{yield}
	end
end