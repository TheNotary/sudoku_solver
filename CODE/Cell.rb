# A cell is just a number.
# If locked = true then it should mean that it was part of the
# original puzzle and should therefore not be changed.
class Cell
	private
	attr_accessor :number, :row, :col, :box

	public
	def initialize(row, col, box)
		@number = 0
		@row = row
		@col = col
		@box = box
	end

	def set(number)
		row.setCell(@number, number)
		col.setCell(@number, number)
		box.setCell(@number, number)

		@number = number
	end

	def isPossible(value)
		return !row.contains(value) && !col.contains(value) && !box.contains(value)
	end

	def nextPossible()
		possible = @number + 1	
		while(possible <= 9)
			if(isPossible(possible))
				break
			end
			possible += 1
		end	
		
		return possible
	end

	def to_s
		return number.to_s
	end
end
