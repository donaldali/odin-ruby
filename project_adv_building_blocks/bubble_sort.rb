
def bubble_sort(array)
	(1...array.length).each do |iteration|
		(0...array.length - iteration).each do |index|
			if array[index] > array[index + 1]
				array[index], array[index + 1] = array[index + 1], array[index]
			end
		end
	end
	array
end

if $PROGRAM_NAME == __FILE__
	p bubble_sort([5,4,3,2,1])
	p bubble_sort([5,8,3,12,1])
end


def bubble_sort_by(array)
	return unless block_given?

	(1...array.length).each do |iteration|
		(0...array.length - iteration).each do |index|
			if yield(array[index], array[index + 1]) > 0
				array[index], array[index + 1] = array[index + 1], array[index]
			end
		end
	end
	array
end

if $PROGRAM_NAME == __FILE__
	# ascending order of length
	p bubble_sort_by(["hi","welcome", "hello","hey"]) { |left,right|
		left.length - right.length
	}
	# decending order of length
	p bubble_sort_by(["hi","welcome", "hello","hey"]) { |left,right|
		right.length - left.length
	}
end