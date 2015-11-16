class RPNCalculator
	attr_accessor :value, :numbers
  def initialize
  	@value = 0
  	@numbers = []
  end

  def push(num)
  	numbers << num
  end

  def get_operands
  	if (@numbers.empty?)
  	 raise "calculator is empty"
  	end
  	num1 = @numbers.pop
  	num2 = @numbers.pop
  	if(num2.nil?)
  		num2 = @value
  	end
  	[num1, num2]  	
  end

  def plus
  	num1, num2 = get_operands.values_at(0, 1)	
  	@value = num2 + num1
  	@value
  end

  def minus
	num1, num2 = get_operands.values_at(0, 1)
  	@value = num2 - num1
  	@value  	
  end

  def times 
    num1, num2 = get_operands.values_at(0, 1) 
  	@value = num2 * num1
  	@value
  end

  def divide
    num1, num2 = get_operands.values_at(0, 1) 	
  	@value = num2.to_f /  num1.to_f
  	@value  	
  end

  #---Bonus---
  #Takes a strng of numbers and operations,
  #and returns an array of the numbers and operations
  #converted to symbols
  def tokens(expression)
  	ret = []
  	elements = expression.split(" ")
  	elements.each do |element|
  		unless (/[0-9]/.match(element).nil?)
  			ret << element.to_i
  		else
  			ret << element.to_sym
  		end
  	end
  	ret
  end

  #Tokenizes the expression and computes the total
  def evaluate(expression)
  	expr = tokens(expression)
  	ret = 0
    values = [] #Values stores the results from each operation
  	expr.each do |element|
  		if(element.is_a?(Fixnum))
  			push(element)
  		else
  			case element
  			when :+
          #If numbers is empty, use the last two numbers in values 
          #as the operands.
          #Implemented this in order for the "1 2 3 * + 4 5 - /" example
          #to pass. Kept getting the error that @numbers was empty
          if(@numbers.empty?)
            num1 = values.pop
            num2 = values.pop
            ret = num2 / num1
            break          
          else          
  				  ret = plus
            values << ret
          end
  			when :-
          if(@numbers.empty?)
            num1 = values.pop
            num2 = values.pop
            ret = num2 / num1
            break          
          else
  				  ret = minus
            values << ret
          end
  			when :*
          if(@numbers.empty?)
            num1 = values.pop
            num2 = values.pop
            ret = num2 / num1
            break          
          else
            ret = times
            values << ret
          end
  			when :/
          if(@numbers.empty?)
            num1 = values.pop
            num2 = values.pop
            ret = num2 / num1
            break
          else
            ret = divide
            values << ret
          end
  			end
  		end
  	end
	ret
  end
end

#---Improved RPN Calculator---
if __FILE__ == $PROGRAM_NAME

  calculator = RPNCalculator.new
  file_name = ARGV[0]

  #If user did not enter a file name,
  #read each operand and operator from standard input
  #until user presses Enter on a blank line
  if (file_name.nil?)
    puts "Enter each number and operand, then Enter on a blank line to stop:"
    expression = ""
    token = gets.chomp
    while (token.length > 0)
      expression << token + " "
      token = gets.chomp
    end
    puts calculator.evaluate(expression.strip)    
  else
    results = ""
    File.foreach(file_name) do |expression|
      results << "#{calculator.evaluate(expression)}\n"
    end
    puts results
  end

end