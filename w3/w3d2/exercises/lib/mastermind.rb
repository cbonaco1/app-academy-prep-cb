class Code
  attr_accessor :pegs
  def initialize(pegs)
    unless (pegs.is_a?(Array))
      raise "Please enter an array into the Code constructor"
    else
      @pegs = pegs  
    end
  end

  PEGS = {
    r: "Red",
    g: "Green",
    b: "Blue",
    y: "Yellow",
    o: "Orange",
    p: "Purple"
  }

  #Takes user input ("RGBY" for example),
  #and builds a new CODE object,
  #Checks the codes the user entered are valid (exist in PEGS)
  def self.parse(code_in)
    codes = code_in.downcase.split("")
    puts "Code entered: #{codes}"
    codes.each do |code|
      unless PEGS.keys.include?(code.to_sym)
        raise "Invalid code entered: #{codes}"
      end  
    end
    Code.new(codes)
  end

  #Return a Code object with random codes
  def self.random
    codes = PEGS.keys.shuffle[1..4].map { |code| code.to_s  }
    Code.new(codes)
  end

  #Override [] to return the index in self.pegs
  def [](index)
    self.pegs[index]
  end

  #Compare two codes and see if there are any exact matches
  #If there are, retun the index where they match
  #If no exact matches, return 0
  def exact_matches(other_code)
    num_matches = 0
    self.pegs.each_with_index do |code, index|
      if(code == other_code[index])
        num_matches += 1
      end
    end
    num_matches
  end

  #Counts near maches
  #Near match occurs when the right code is in the wrong spot
  def near_matches(other_code)
    num_matches = 0
    matches = []
    i = 0
    while (i < self.pegs.length)
      j = 0
      while (j < other_code.pegs.length)
        if(self[i] == other_code[j])
          if(i != j)
            unless (matches.include?(self[i]))
              num_matches += 1
              matches << self[i]
            end
          else
            if(matches.include?(self[i]))
              num_matches -= 1
            end
          end
        end
        j += 1
      end
      i += 1
    end
    num_matches
  end

  def ==(other_code)
    ret = false
    if(other_code.is_a?(Code))
      code_one = self.pegs.join("").downcase
      code_two = other_code.pegs.join("").downcase
      ret = (code_one == code_two) ? true : false
    end
    ret
  end

end

class Game
  attr_accessor :turns, :max_turns, :secret_code

  def initialize(secret_code_in=Code.random)
    @turns = 0
    @max_turns = 5
    @secret_code = secret_code_in
  end

  def get_guess
    puts "Please enter your guess in the form (cccc) where c is code for a color:"
    code = gets.chomp
    Code.parse(code)
    rescue Exception => e
      #If the user enters a bad code, try again
      puts "#{e}"
      retry
  end

  def display_matches(code)
    puts "exact matces: #{self.secret_code.exact_matches(code)}"
    puts "near matches: #{self.secret_code.near_matches(code)}"
  end

  def play
    while(self.turns < self.max_turns)
      user_guess = get_guess
      self.turns += 1
      if(user_guess == self.secret_code)
        puts "Congrats, you have guessed the secret code!"
        break
      else
        puts "--Incorrect guess--"
        puts "Guess number #{self.turns} of #{self.max_turns}"
        self.display_matches(user_guess)
        puts "-------------------"
      end
    end

    if(self.turns == self.max_turns)
      puts "Sorry you are out of turns"
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  #blue_code = Code.new("bbbb".split(""))
  #orange_code = Code.new("oooo".split(""))
  code1 = Code.new("yybb".split(""))
  code2 = Code.new("bbob".split(""))

  #puts code2.near_matches(code1)
  game = Game.new
  game.play
end