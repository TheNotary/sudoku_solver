load 'Cell.rb'

# A Block is supposed to be either a row, block or column in the soduku
# table. This means it contains 9 cells.
class Block
	attr_accessor :values
	
	def initialize
		@values = 0
	end
	
	def setCell(oldvalue, newvalue)
		if(oldvalue != 0 && contains(oldvalue))
			@values -= (1 << oldvalue)
		end
		
		if(newvalue != 0)
			@values |= (1 << newvalue)	
		end		
	end

	def contains(value)
		return @values & (1 << value) == (1 << value)
	end

end
