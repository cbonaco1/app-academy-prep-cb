class XmlDocument
  @@num_spaces = -2
  attr_accessor :indents, :spaces
  def initialize(indents=false)
  	@indents = indents
    @spaces = 0
  end

  def send(tag_name, attributes={}, &block)
    xml = ""
  	if(block_given?)
  		xml << "#{open_tag(tag_name)}"
      indent
      xml << "#{block.call}"
      unindent
      xml << "#{closing_tag(tag_name)}"
  	else
      xml << lone_tag(tag_name, attributes)       		
  	end
    xml
  end

  def method_missing(method_name, arguments={}, &block)
    send(method_name, arguments, &block)
  end

  def open_tag(name)
    "#{tab}<#{name}>#{new_line?}"
  end

  def closing_tag(name)
    "#{tab}</#{name}>#{new_line?}"
  end

  def lone_tag(name, attrs={})
    body = ([name] + attribute_string(attrs)).join(" ")
    "#{tab}<#{body}/>#{new_line?}"
  end

  #Take a Hash of the attributes and return an Array
  #with each element being key="value"
  def attribute_string(attributes)
    attributes.map { |name, value| "#{name}=\"#{value}\""  }
  end

  def indent
    @spaces += 2 if @indents
  end

  def unindent
    @spaces -= 2 if @indents
  end

  def new_line?
    @indents ? "\n" : ""
  end

  def tab
    " " * @spaces
  end

end