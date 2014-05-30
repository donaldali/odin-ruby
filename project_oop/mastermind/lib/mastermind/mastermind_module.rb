# Constants and helper functions for the Mastermind game
module Mastermind
	MAX_GUESSES = 12
	BOARD_WIDTH = 4

	COLORS = { blank: 0, red: 1, green: 2, yellow: 3,
	           blue: 4, magenta: 5, cyan: 6, white: 7, black: 8 }

	def get_user_input(prompt)
		print prompt
		gets.chomp
	end

	# Determine how close to the secret a guess is
	def rate_guess(guess, secret)
		unmatched_guess = []
		unmatched_secret = []
		blacks = 0 # right color right place
		whites = 0 # right color wrong place

		guess.each_with_index do |a_guess, index|
			if a_guess == secret[index]
				blacks += 1
			else
				unmatched_guess << a_guess
				unmatched_secret << secret[index]
			end
		end

		unmatched_guess.each do |a_guess|
			index = unmatched_secret.index(a_guess)
			unless index.nil?
				unmatched_secret.delete_at(index)
				whites += 1
			end
		end
		[blacks, whites]
	end

	# Color code is expected. Eg "1;32;42"
	def colorize(text, color_code)
		"\033[#{color_code}m#{text}\033[0m"
	end

  # Color is expected as a number (0 - 8)
	def get_color_code color
		return "1;31;41" if color == COLORS[:red]
		return "1;32;42" if color == COLORS[:green]
		return "1;33;43" if color == COLORS[:yellow]
		return "1;34;44" if color == COLORS[:blue]
		return "1;35;45" if color == COLORS[:magenta]
		return "1;36;46" if color == COLORS[:cyan]
		return "1;37;47" if color == COLORS[:white]
		return "1;30;40" if color == COLORS[:black]
		return "0"
	end

  # Color is expected as a sting or symbol. Eg "red" or :red
	def color(text, color)
		if color == "error"
			colorize(text, "31")
		elsif color == "warning"
			colorize(text, "33")
		elsif color == "bold"
			colorize(text, "7")
		else
			colorize(text, get_color_code(COLORS.fetch(color.to_sym, 0)))
		end
	end
end
