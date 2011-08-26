load 'Block.rb'

class BlockTest < Block
	def initialize
		super
		
	end

public
	def testSet()
		self.setCell(0, 1)
		if !self.contains(1) 
			puts "Failed. 1"
			show
		end		
	
		self.setCell(0,0)
		if self.contains(0)
			puts "Failed. 2"
		end

		self.setCell(1,0)
		if self.contains(1)
			puts "Failed. 3"
		end

		1.upto(16) do |i|
			self.setCell(0,i)
			if !self.contains(i)
				puts "Failed. 4. " + i.to_s + "."
			end
		end

		1.upto(16) do |i|
			if !self.contains(i)
				puts "Failed. 5. " + i.to_s + "."
			end
		end
		self.show
	end

	def show()
		1.upto(9) do |i|		
			if values & (2 << i) == (2 << i)
				print i
			end
		end	
		puts	
		
	end

end

test = BlockTest.new
test.testSet

puts "Test"
