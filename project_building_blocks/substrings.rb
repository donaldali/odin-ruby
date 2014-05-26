def substrings(words, dictionary)
	substrings_hash = {}
	words.downcase!

	dictionary.each do |substring|
		substring_occurrences = words.scan(/#{substring.downcase}/).length
		substrings_hash[substring] = substring_occurrences unless substring_occurrences.zero?
	end
	substrings_hash
end

if $PROGRAM_NAME == __FILE__
	dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
	p substrings("below", dictionary)
	p substrings("Howdy partner, sit down! How's it going?", dictionary)
end
