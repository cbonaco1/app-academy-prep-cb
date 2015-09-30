#convert degrees from farenheit to celcius
def ftoc(degrees)
	(degrees - 32) * (5.0/9.0)
end

#convert degrees from celcius to farenheit
def ctof(degrees)
	(degrees * (9.0/5.0)) + 32
end