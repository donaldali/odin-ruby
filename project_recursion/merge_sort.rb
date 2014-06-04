# Sort an array using the merge sort algorithm
def merge_sort array
	return array if array.length <= 1
	mid = array.length / 2
	merge(merge_sort(array[0..mid - 1]), merge_sort(array[mid..-1]))
end

def merge(array1, array2)
	merged_array = []
	i, j = 0, 0
	while i < array1.length && j < array2.length
		if array1[i] < array2[j]
			merged_array << array1[i]
			i += 1
		else
			merged_array << array2[j]
			j += 1
		end
	end
	merged_array.concat array1[i..-1]
	merged_array.concat array2[j..-1]
end
