# Create the first n fibonacci numbers iteratively
def fibs num
	return [1] * num.to_i if num.to_i <= 2
	(3..num).to_a.inject([1, 1]) { |fib_nums, _ele| fib_nums << fib_nums[-1] + fib_nums[-2] }
end

# Create the first n fibonacci numbers recursively
def fibs_rec num
	return [1] * num.to_i if num.to_i <= 2
	last = fibs_rec(num - 1)
	last << last[-1] + last[-2] 
end
