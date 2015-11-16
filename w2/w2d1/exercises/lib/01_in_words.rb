class Fixnum
	#Return the word version of a number
	def in_words
		ret = ""
		ones = {
			0=>"zero", 
			1=>"one",
			2=>"two",
			3=>"three",
			4=>"four",
			5=>"five",
			6=>"six",
			7=>"seven",
			8=>"eight",
			9=>"nine"
		}
		tens = {
			2=>"twenty",
			3=>"thirty",
			4=>"forty",
			5=>"fifty",
			6=>"sixty",
			7=>"seventy",
			8=>"eighty",
			9=>"ninety"
		}
		teens = {
			10=>"ten",
			11=>"eleven",
			12=>"twelve",
			13=>"thirteen",
			14=>"fourteen",
			15=>"fifteen",
			16=>"sixteen",
			17=>"seventeen",
			18=>"eighteen",
			19=>"nineteen"
		}

		if(self.to_s.length == 1)
			return ones[self]
		end
		if( (self >= 10) && (self < 20) )
			return teens[self]
		elsif ((self >= 20) && (self <= 99))
			number_of_tens = self / 10
			number_of_ones = (self % 10 > 0) ? self % 10 : nil

			return "#{tens[number_of_tens]} #{ones[number_of_ones]}".strip
		else
			unit = ""
			div = 1
			num_str_len = self.to_s.length

			case 
			when (num_str_len == 3)
				unit = "hundred"
				div = 100
			when (num_str_len >= 4) && (num_str_len <= 6)
				unit = "thousand"
				div = 1000
			when (num_str_len >= 7) && (num_str_len <= 9)
				unit = "million"
				div = 1000000
			when (num_str_len >= 10) && (num_str_len <= 12)
				unit = "billion"
				div = 1000000000				
			end

			how_many = determine_how_many(self, div)
			ret << "#{how_many} #{unit} "

			rest = determine_rest(self, div)
			unless rest == 0
				ret << rest.in_words	
			end
		end
		ret.strip
	end
end

class Bignum
	def in_words
		ret = ""
		unit = ""
		div = 1
		num_str_len = self.to_s.length	

		case 
		when (num_str_len >= 10) && (num_str_len <= 12)
			unit = "billion"
			div = 1000000000				
		when (num_str_len >= 13) && (num_str_len <= 15)
			unit = "trillion"
			div = 1000000000000			
		end

		how_many = determine_how_many(self, div)
		ret << "#{how_many} #{unit} "	

		rest = determine_rest(self, div)
		unless rest == 0
			ret << rest.in_words	
		end

		ret.strip
	end
end


#Determnes how many of the unit
#98,123 / 1000 = 98 = "ninety eight"
def determine_how_many(number, unit)
	(number / unit).in_words
end

#Determine the rest of the number
#98,123 => 123
def determine_rest(number, unit)
	number - ((number / unit) * unit)
end