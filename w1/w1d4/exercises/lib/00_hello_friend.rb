class Friend
  def greeting(who=nil)
  	msg = ""
  	if(who)
  		msg = "Hello, #{who}!"
  	else
  		msg = "Hello!"
  	end
  	msg
  end
end