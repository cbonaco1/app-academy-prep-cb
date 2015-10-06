class Temperature
	attr_accessor :unit, :degree

	#Constructor takes in an options hash as an argument,
	#whose key-value pair is unit->degees (:f->100 for example)
	def initialize(degrees={})
		if(degrees.is_a?(Hash))
			#only set the instance variables for Temperate object
			#to the values of the first key/value pair in degrees hash
			@unit = degrees.keys[0]
			@degree = degrees.values[0]
		end
	end

	#Convert the degrees to farenheit
	def in_fahrenheit
		if(@unit.to_s == "f")
			@degree
		else
			(@degree * (9.0/5.0)) + 32
		end
	end

	#Convert the degrees to celsius
	def in_celsius
		if(@unit.to_s == "c")
			@degree
		else
			(@degree - 32) * (5.0/9.0)
		end
	end

	#Class factory method to create a Temperature object with Celsius unit
	def self.from_celsius(degrees)
		Temperature.new({:c=>degrees})
	end

	#Class factory method to create a Temperature object with Farenheit unit
	def self.from_fahrenheit(degrees)
		Temperature.new({:f=>degrees})
	end
end

#Celsius subclass of Temperature
class Celsius < Temperature
	def initialize(degreesIn)
		super({:c=>degreesIn})
	end
end

#Fahrenheit subclass of Temperature
class Fahrenheit < Temperature
	def initialize(degreesIn)
		super({:f=>degreesIn})
	end	
end