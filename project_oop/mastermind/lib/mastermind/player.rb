# A player of the mastermind game
class Player
	attr_reader :name, :score

	def initialize name
		@name = name
		@score = 0
	end

	def increase_score
		@score += 1
	end

	# Get the colors from the player that would be the secret code
	def make_code
		get_colors_from_player MAKE_CODE_PROMPT
	end

	# Get the player's guess as a list of colors
	def make_guess
		get_colors_from_player MAKE_GUESS_PROMPT
	end

	def human?
		true
	end

	def ai?
		false
	end

  # *********************************************
  # ************  PRIVATE METHODS  **************
  # *********************************************
	private

	# Get a list of colors from the human player
	def get_colors_from_player(prompt)
		while true
			colors = encode_input Mastermind.get_user_input(prompt)
			return colors unless colors.nil?
			puts Mastermind.color(INVALID_INPUT_MESSAGE, "error")
		end
	end

	# Begin processing user's list of colors
	def encode_input input
		if input.strip.length == Mastermind::BOARD_WIDTH
			input = input.strip.split("").join(",")
		end
		colors = input.split(",").join(" ").split(" ")
		return nil if colors.length != Mastermind::BOARD_WIDTH

		encode_colors colors
	end

	# Encode each inputted color
	def encode_colors colors
		encoded_colors = []
		colors.each do |color|
			encoded_color = encode_color color
			return nil if encoded_color.nil?
			encoded_colors << encoded_color
		end
		encoded_colors
	end

	# Convert the string representation of a color to a number
	def encode_color color
		case color.downcase
		when 'red',     'r' then Mastermind::COLORS[:red]
		when 'green',   'g' then Mastermind::COLORS[:green]
		when 'yellow',  'y' then Mastermind::COLORS[:yellow]
		when 'blue',    'b' then Mastermind::COLORS[:blue]
		when 'magenta', 'm' then Mastermind::COLORS[:magenta]
		when 'cyan',    'c' then Mastermind::COLORS[:cyan]
		else nil
		end
	end

	MAKE_CODE_PROMPT = "Enter your secret code as a comma-separated list of " \
			               "#{ Mastermind::BOARD_WIDTH } colors." \
			               "\nEnter Code: "
  MAKE_GUESS_PROMPT = "Enter your guess as a comma-separated list of " \
			                "#{ Mastermind::BOARD_WIDTH } colors." \
			                "\nEnter Guess: "
	INVALID_INPUT_MESSAGE = "Invalid Input. Please enter colors separated " \
	                        "by a comma and/or space.\n"\
	                        "You may enter the full name of a color or "\
	                        "its first letter (e.g. 'yellow' or 'y')."
end
