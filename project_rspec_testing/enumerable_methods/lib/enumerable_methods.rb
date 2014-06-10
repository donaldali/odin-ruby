module Enumerable
	def my_each
		for element in self
			yield(element)
		end
		self
	end

	def my_each_with_index
		index = 0
		self.my_each { |element| yield(element, index); index += 1 }
		self
	end

	def my_select
		result = []
		self.my_each { |element| result << element if yield(element) }
		result
	end

	def my_all?
		self.my_each { |element| return false unless yield(element) }
		true
	end

	def my_any?
		self.my_each { |element| return true if yield(element) }
		false
	end

	def my_none?
		self.my_each { |element| return false if yield(element) }
		true
	end

	def my_count
		count = 0
		self.my_each do |element| 
			count += if block_given?
				         yield(element) ? 1 : 0
				       else
				       	 1
				       end
		end
		count
	end

	# When a block and a Proc are both provided, the block is 
	# first run on the individual elements and the Proc is then
	# run on the result of the block's operation
	def my_map(proc = nil)
		result = []
		if proc && block_given?
			self.my_each { |element| result << proc.call(yield(element)) }
		elsif proc && !block_given?
			self.my_each { |element| result << proc.call(element) }
		elsif proc.nil? && block_given?
			self.my_each { |element| result << yield(element) }
	  else
	  	self
		end
		result
	end

	def my_inject(initial = nil)
		initial = self[0] if initial.nil?
		memo = initial
		self.my_each { |element| memo = yield(memo, element) }
		memo
	end
end

def multiply_els array
	array.my_inject(1) { |product, element| product * element }
end
