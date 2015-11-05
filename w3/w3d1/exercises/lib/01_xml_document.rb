class XmlDocument
  @@num_spaces = -2
  attr_accessor :indents
  def initialize(indents=false)
  	@indents = indents
  end

  def send(tag_name, attributes={}, &block)
    num_spaces = 0
    puts "Spaces == #{num_spaces}"
  	if(block_given?)
      block_result = block.call
  		return "#{spaces(num_spaces)}<#{tag_name}>#{new_line?}" + 
  				   "#{spaces(num_spaces)}#{block_result}#{new_line?}" +
  				   "#{spaces(num_spaces)}</#{tag_name}>#{new_line?}"
  	else
	  	if(attributes.empty?)
	  		return "<#{tag_name}/>#{new_line?}"
	  	else
        attribute_str = ""
        attributes.each do |attr, value|
          attribute_str += "#{attr}=\"#{value}\" "
        end 
        return "<#{tag_name} #{attribute_str.strip}/>#{new_line?}"      
	  	end  		
  	end
  end


  def method_missing(method_name, arguments={}, &block)
  	send(method_name, arguments, &block)
  end

  def indent?
    space = ""
    if(@indents)
      @@spaces.times do 
        space += " "
      end
    end
    #puts "Returning --#{space}--"
    space
  end

  def new_line?
    @indents ? "\n" : ""
  end

  def spaces(num_spaces)
    ret = ""
    num_spaces.times do
      ret << "-"
    end
    ret
  end

end

xml =XmlDocument.new(true)
puts xml.send("Hello")
puts xml.goodbye
puts xml.hello(:name => "dolly", :class => "test", :id => "new_field")
puts xml.hello { "dolly" }
puts "------"

#xml_string = xml.hello do
  xml_string = xml.goodbye do
    xml.come_back do
      xml.hello(:name => "dolly")
    end
 end
#end
puts xml_string