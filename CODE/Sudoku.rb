#!/usr/bin/env ruby
load 'Block.rb'

class Sudoku
	attr_accessor :cells, :unsolved
	
	def initialize()
		@cells = []
		@unsolved = []
	end

	# Parses the puzzle into rows, columns and boxes
	def parse(input)	
		lines = input.each_line 

		rows = []
		boxes = []
		cols = []
		1.upto(9) {
			rows << Block.new
			boxes << Block.new
			cols << Block.new		
		}

		r = 0 # The current row
		cell_index = 0 # The current cell

		lines.each do |line|
			if r > 8 
				break
			end
			numbers = line.split(',')	
			c = 0 # The current column
			
			numbers.each do |number|				
				b = c / 3 + 3 * (r / 3) # The current box
				number = number.delete ","
				number = number.to_i
				
				cell= Cell.new(rows[r], cols[c], boxes[b])
				#print r.to_s + c.to_s + b.to_s + " "
				number = 0 if number == nil
				cell.set(number)

				if number == 0
					@unsolved << cell
				end
								
				@cells[cell_index] = cell;
				
				c += 1
				cell_index += 1 
			end	
			r += 1 
			#puts
		end
		#puts
		#show
		#gets
	end

	# Attempts to solve the puzzle
	# returns true or false depending on whether or not it solved the puzzle
	def solve
		
		cell_index = 0
		# move to the right position..
		# puts @unsolved.length.to_s + " unknown cells!"

		while cell_index >= 0 && cell_index < @unsolved.length do
			cell = @unsolved[cell_index];
			
			possible = cell.nextPossible()	

			if possible > 9 || possible <= 0
				cell.set(0)
				cell_index -= 1
			else
				cell.set(possible)
				cell_index += 1
			end							
		end

		if cell_index < 0
			return false
		else
			return true
		end
	end

	def show
		puts to_s
	end

	def to_s
		s = ""
		i = 0
		@cells.each do |cell| 
			if i % 9  == 0 && i > 0
				s += "\n"
			end		
	
			s += cell.to_s	
			if (i+1) % 9 != 0
				s += ","
			end		
			i += 1
		end
		return s
	end

end

if ARGV.count < 1
	puts "Usage: Sudoku.rb <inputfile>"
	puts "Optional-usage: Sudoku.rb <inputfile> <outputfile>"
	exit
end

#input = File.open(ARGV[0])
# edits get made here so I don't have to touch the FS

input = ARGV[0].gsub('n', "\n")

#puts input;

puzzle = Sudoku.new
puzzle.parse(input)

#puzzle.show
before = Time.now()
solved = puzzle.solve()
diff = Time.now() - before
puts "Solved for: " + diff.to_s  + " seconds"
if !solved
   puts "Unable to solve!"
elsif ARGV.count > 1
   f = File.open(ARGV[1], "w")
   f.puts puzzle.to_s
else
    puzzle.show	
end



