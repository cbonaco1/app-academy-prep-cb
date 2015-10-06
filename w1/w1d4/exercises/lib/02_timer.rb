class Timer
	attr_reader :time_string
	attr_accessor :seconds

	def initialize(secondsIn=0)
		@seconds = secondsIn
		@time_string = nil
	end

	#sets the time_string instance variable
	def time_string
		seconds = @seconds % 60
		minutes = (@seconds / 60) % 60
		hours = @seconds / (60 * 60)
		padded(hours.to_s) + ":" + padded(minutes.to_s) + ":" + padded(seconds.to_s)
	end

	#prepends a zero to time if length is 1
	def padded(time)
		ret = ""
		if(time.to_s.length == 1)
			ret = "0" + time.to_s
		else
			ret = time.to_s
		end
		ret
	end
end