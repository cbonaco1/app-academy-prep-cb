def measure(rounds=1)
	if block_given?
		start_time = Time.now
		rounds.times do
			yield
		end
		end_time = Time.now
		total = end_time - start_time
		total / rounds		
	end
end