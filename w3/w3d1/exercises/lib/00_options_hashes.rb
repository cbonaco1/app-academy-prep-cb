# Options Hashes
#
# Write a method `transmogrify` that takes a `String`. This method should
# take optional parameters `:times`, `:upcase`, and `:reverse`. Hard-code
# reasonable defaults in a `defaults` hash defined in the `transmogrify`
# method. Use `Hash#merge` to combine the defaults with any optional
# parameters passed by the user. Do not modify the incoming options
# hash. For example:
#
# ```ruby
# transmogrify("Hello")                                    #=> "Hello"
# transmogrify("Hello", :times => 3)                       #=> "HelloHelloHello"
# transmogrify("Hello", :upcase => true)                   #=> "HELLO"
# transmogrify("Hello", :upcase => true, :reverse => true) #=> "OLLEH"
#
# options = {}
# transmogrify("hello", options)
# # options shouldn't change.
# ```

def transmogrify(str, options={})
	defaults = {
		times: 1,
		upcase: false,
		reverse: false
	}
	options = defaults.merge(options)

	str = options[:upcase] ? str.upcase : str
	str = options[:reverse] ? str.reverse : str

	new_str = ""
	options[:times].times do
		new_str += str
	end
	new_str
end

word = "foo "
options = { times: 3, upcase: true, reverse: true }
puts transmogrify(word, options)