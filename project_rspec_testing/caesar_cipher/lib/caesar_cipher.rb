
def caesar_cipher(message, shift)
	return "Invalid arguments" unless message.is_a?(String) && shift.is_a?(Integer)

	shift %= 26
	message.split('').map { |char| encode(char, shift) }.join
end


def encode(char, shift)
	if char.between?('a', 'z')
		encode_upper_bound(char, shift, 'z')
	elsif char.between?('A', 'Z')
		encode_upper_bound(char, shift, 'Z')
	else
		char
	end
end


def encode_upper_bound(char, shift, upper_bound)
	char_encoded_int = char.ord + shift
	char_encoded_int -= 26 if char_encoded_int > upper_bound.ord
	char_encoded_int.chr
end

if $PROGRAM_NAME == __FILE__
	puts caesar_cipher("What a string!", 5)
	puts caesar_cipher("abcdefghijklmnopqrstuvwxyz", 263)
	puts caesar_cipher("WhaT, As...", -2)
	puts caesar_cipher("Some Message", "Bad")
end
