#returns the sum of two numbers
def add(num1, num2)
	num1 + num2
end

#returns the second number subtracted from the first
def subtract(num1, num2)
	num1 - num2
end

#returns the sum of an array of numbers
def sum(nums)
	sum = 0
	nums.each{|num| sum += num}
	sum
end

#returns the sum of two or more numbers
#use the splat operator on nums parameter to convert the parameter list into an array
#this is because we dont know how many arguments are being passed
def multiply(*nums)
	product = 1
	nums.each{|num| product *= num}
	product
end

#return the first number (base) raised to the power power
def power(base, power)
	base ** power
end

#returns n factorial
def factorial(n)
	if(n > -1)
		if(n == 0)
			return 1
		else
			n * factorial(n-1)
		end
	end
end