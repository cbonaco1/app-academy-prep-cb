class Dictionary
  attr_accessor :entries
  attr_writer :keywords
  
  def initialize(entriesIn={})
  	@entries = entriesIn
  	@keywords = entriesIn.keys
  end

  #getter for keywords - print them out in alphabetical order
  def keywords
  	@keywords.sort
  end

  #adds keyword->definition pair to entires
  #definition may be nil
  def add(word_to_add)
  	#a key value pair can be passed in, or just a key (word with no definition)
    word = ""
    definition = nil
    #if argument is a hash, then add the key and value
    if(word_to_add.is_a?(Hash))
      word = word_to_add.keys[0]
      definition = word_to_add.values[0]
    else
      #if argument is not a hash, just add the word
      word = word_to_add
    end

    @entries[word] = definition
    @keywords << word  	
  end

  #returns true/false if the keyword exists in the dictionary
  def include?(keywordIn)
  	@keywords.include?(keywordIn) ? true : false
  end

  #returns key-value pair of keywords in entries which contain keywordIn
  #uses a RegEx to see if keywordIn matches with any of the keywords in entries
  def find(keywordIn)
  	@entries.select{|word, definition| /#{keywordIn}/.match(word) }
  end

  #prints out all the keywords->definitions like so: [keyword] 'definition'
  #in alphabetical order
  #TO-DO: ask about this - not sure what format theyre expecting
  def printable
  	self.keywords.each do |keyword|
      puts %Q{[#{keyword}] \'#{@entries[keyword]}\'}
    end
  end
end

d = Dictionary.new
d.add("zebra" => "African land animal with stripes")
d.add("fish" => "aquatic animal")
d.add("apple" => "fruit")
d.printable