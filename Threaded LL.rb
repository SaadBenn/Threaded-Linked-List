class Book
	attr_accessor :title , :creator, :year, :pages
	
	def initialize(title, creator, year, pages)
		@title = title
		@creator = creator
		@year = year
		@pages = pages
		@author = creator
	end

	def compareTo(data, top)
		result = -1
		if self.instance_variable_defined?(top)
		  result = self.instance_variable_get(top) .casecmp data.instance_variable_get(top)
		end
		return result
	end

	def to_s
		result = "Book: title='#{@title}' author = #{@creator} year = #{@year} pages=#{@pages} \n"
		return result
	end
end


class Album
	attr_accessor :title , :creator, :year

	def initialize(title, creator, year)
		@title = title
		@creator = creator
		@year = year
		@artist = creator
	end

	def compareTo(data, top)
		result = -1
		if self.instance_variable_defined?(top)
		  result = self.instance_variable_get(top) .casecmp data.instance_variable_get(top)
		end
		return result
	end

	def to_s
		result = "Album: title='#{@title}' Artist = #{@creator} year = #{@year} \n"
		return result
	end
end

class Movie
	attr_accessor :title , :creator, :year, :star
	
	def initialize(title, creator, year, star)
		@title = title
		@creator = creator
		@year = year
		@star = star
		@director = creator
	end

	def compareTo(data, top)
		result = -1

		if self.instance_variable_defined?(top)
		if data.instance_variable_get(top) != nil
		  result = self.instance_variable_get(top) .casecmp data.instance_variable_get(top)
		end
		end
		return result
	end

	def to_s
		result = "Movie: title='#{@title}' Artist = #{@creator} year = #{@year}"
		result = result.concat(" Star = #{@star}") unless @star.nil?
		result.concat("\n")
		return result
	end
end

class Node
 attr_accessor :data, :pointer
 
 def initialize(data)
	@data = data
	@pointer = Hash.new
	vars = data.instance_variables
	vars.each {|keys|
	 @pointer[keys.to_s + 'Top'] = nil
	}
 end

 def to_s
   result = data.to_s
   return result
 end

end

class List
  attr_accessor :tops
  
  def initialize
    @tops = Hash.new
  end
  
  def add(data)
    keys = data.instance_variables

    if keys == []
      result = ''
      result = result.concat( "Item 'Bad text' (#{data.class}) does not have indexes; unable to add to list")
      puts result
    else

      node = Node.new(data)
      keys.each{ |vars|
        if (@tops.has_key?(vars.to_s + 'Top')) == false
          @tops[vars.to_s + 'Top']
        end
        if node.data.instance_variable_get(vars) != nil
          insertItem(node, vars)
        end

      }
    end
  end

  def insertItem(node, top)
    prev = nil
    curr = @tops[top.to_s + 'Top']
    found = false
    
    while curr != nil && found == false
      if curr.data.instance_variable_defined?(top)
        if(curr.data.compareTo(node.data, top)) >= 0
          found = true
        else
          prev = curr
          curr = curr.pointer[top.to_s + 'Top']
        end
      end
    end

    if prev.nil?
      node.pointer[top.to_s + 'Top'] = @tops[top.to_s + 'Top']
      @tops[top.to_s + 'Top'] = node
    else
      node.pointer[top.to_s + 'Top'] = curr
      prev.pointer[top.to_s + 'Top'] = node
    end
  end
  
  def to_s(top)
    result = ''
    data = @tops[top]
    while data!= nil
      result.concat(data.to_s)
      data = data.pointer[top]
    end
    return result
  end
  
  def print
    result = ''
    vars = @tops.keys
    vars.each{|listTile|
      result.concat(listTile[1..-4])
      result.concat("\n------------------------\n")
      result.concat(self.to_s(listTile))
    }
    return result
  end
end

def procesFile(list, fileName)
  
  fin = File.open(fileName, "r")
  puts "Original List \n------------------------\n"
  fin.each_line do |inLine|
    tokens = inLine.split(",")

    if tokens[0] == "Book"
      book = Book.new(tokens[1], tokens[2],tokens[3],tokens[4])
      puts book.to_s
      list.add(book)
    elsif tokens[0] == "Album"
      album = Album.new(tokens[1], tokens[2],tokens[3])
      puts album.to_s
      list.add(album)
    elsif tokens[0] == "Movie"
      star = nil
      if tokens.length == 5
        star = tokens[4]
      end
      movie = Movie.new(tokens[1], tokens[2],tokens[3], star)
      puts movie.to_s
      list.add(movie)
    else
      list.add(inLine)
    end
  end
end

def printAll(list)
  puts list.print
end

list = List.new
procesFile(list, ARGV[0])
printAll(list)
