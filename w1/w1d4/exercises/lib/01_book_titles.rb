class Book
  attr_reader :title
  def initialize(titleIn=nil)
  	@title = titleIn
  end

  #setter method for the title instance variable
  #getter created with attr_reader
  def title=(titleIn)
  	@title = capitalize(titleIn)
  end

  #capitalize the title the user passes in before setting it
  #to the title instance variable
  def capitalize(titleIn)
  	ret = ""
  	#These are the words not to capitalize if they are not the first word
  	little_words = ["the", "a", "an", "in", "and", "of"]

  	words = titleIn.split(" ")
  	words.each_with_index do |word, index|
  		if(index > 0)
  			unless (little_words.include?(word))
  				ret << word.capitalize + " "
  			else
  				ret << word + " "
  			end  			
  		else
    		#capitalize first word regardless
  			ret << word.capitalize + " "
  		end
  	end
  	ret.strip
  end
end
