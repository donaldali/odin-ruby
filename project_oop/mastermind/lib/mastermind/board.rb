# Gameboard for the Mastermind game
class Board
	HOLE_SIZE = 3
	RATING_SIZE = 2

	# Set up the gameboard
	def initialize
		reset_board
	end

	# Clear all positions on the Mastermind gameboard
	def reset_board
		@secret_board = []
		Mastermind::BOARD_WIDTH.times { @secret_board << Mastermind::COLORS[:blank] }
		@decoding_board = blank_board
		@rating_board = blank_board
	end

	# Display the entire board (with some instructions)
	def display_board(hide_secret = false)
		display_colors
		display_decoding_rating_board
		display_secret_board(hide_secret)
	end

	# Re-render gameboard after one of the boards changes
	def refresh_board(board_type, board_row, hide_secret, row_number = 0)
		case board_type
		when :secret then update_secret_board(board_row)
		when :decoding then update_decoding_board(board_row, row_number)
		when :rating then update_rating_board(board_row, row_number)
		end

		display_board(hide_secret)
	end

	# Convert the rating of guess to a format that can be easily displayed
	def rating_board_data(rating)
		data = []
		rating[0].times { data << Mastermind::COLORS[:black] }
		rating[1].times { data << Mastermind::COLORS[:white] }
		(Mastermind::BOARD_WIDTH - rating[0] - rating[1]).times do
			data << Mastermind::COLORS[:blank]
		end
		data
	end

  # *********************************************
  # ************  PRIVATE METHODS  **************
  # *********************************************
	private

	def update_secret_board(board)
		@secret_board = board
	end

	def update_decoding_board(board_row, row_number)
		@decoding_board[row_number] = board_row
	end

	def update_rating_board(board_row, row_number)
		@rating_board[row_number] = board_row
	end

	# Create a blank board
	def blank_board
		blank_board = []
		Mastermind::MAX_GUESSES.times do
			blank_board << get_blank_row
		end
		blank_board
	end

	# Create a blank row on the board
	def get_blank_row
		blank_row = []
		Mastermind::BOARD_WIDTH.times { blank_row << Mastermind::COLORS[:blank] }
		blank_row
	end

	# Display colors players may choose from
	def display_colors
		print "\nColors: "
		Mastermind::COLORS.each do |color, _color_code|
			unless color == :blank || color == :black || color == :white
				color_string = color.to_s.capitalize
				print Mastermind::color("  #{color_string}  ", color)
			end
		end
		puts "\nChoose a color with it's full name or it's first character"
	end

	# Display the board guesses are made on
	def display_decoding_rating_board
		display_both_tops
		display_both_centers
		display_both_bottoms
	end

	# Display the center of the decoding and rating boards
	def display_both_centers
		@decoding_board.each_with_index do |decoding_row, index|
			rating_row = @rating_board[index]

			display_row(decoding_row, HOLE_SIZE, false)
			print " "
		  display_row(rating_row, RATING_SIZE, true, false)

		  if index < @decoding_board.length - 1
		  	display_boards_separators(method(:display_middle_separator))
		  end
		end
	end

	# Display the separators between colors on the board
	def display_boards_separators separator_display_method
		separator_display_method.call(HOLE_SIZE, false)
		print " "
		separator_display_method.call(RATING_SIZE, true, false)
	end

	# Display the top of the decoding and rating boards
	def display_both_tops
		display_boards_separators(method(:display_top_separator))
	end

	# Display the bottom of the decoding and rating boards
	def display_both_bottoms
		display_boards_separators(method(:display_bottom_separator))
	end

	# Display the board with the secret code
	def display_secret_board hide_secret
		display_top_separator
		display_row(get_blank_row) if hide_secret
		display_row(@secret_board) unless hide_secret
		display_bottom_separator
	end

	# Display a row on row that has colors
	def display_row(row, width = HOLE_SIZE, new_line = true, tab = true)
		print "\t" if tab
		row.each do |hole_color| 
			print SEPARATOR[:vertical]
			print Mastermind::colorize(" " * width, 
				                         Mastermind::get_color_code(hole_color))
		end
		print SEPARATOR[:vertical]
		puts if new_line
	end

	# Display top separator of any board
	def display_top_separator(width = HOLE_SIZE, new_line = true, tab = true)
		display_separator_row(SEPARATOR[:nw_corner], SEPARATOR[:n_divide], 
			                    SEPARATOR[:ne_corner], width, new_line, tab)
	end

	# Display middle separator of any board
	def display_middle_separator(width = HOLE_SIZE, new_line = true, tab = true)
		display_separator_row(SEPARATOR[:w_divide], SEPARATOR[:cross], 
			                    SEPARATOR[:e_divide], width, new_line, tab)
	end

	# Display bottom separator of any board
	def display_bottom_separator(width = HOLE_SIZE, new_line = true, tab = true)
		display_separator_row(SEPARATOR[:sw_corner], SEPARATOR[:s_divide], 
			                    SEPARATOR[:se_corner], width, new_line, tab)
	end

	# Display any type of separator row based on input
	def display_separator_row(left, middle, right, width, new_line, tab)
		print "\t" if tab
		to_display = left
		Mastermind::BOARD_WIDTH.times do
			width.times { to_display += SEPARATOR[:horizontal] }
			to_display += middle
	  end
	  to_display[to_display.length - 1] = right

	  print to_display
	  puts if new_line
	end

	SEPARATOR = { vertical:  "\u2551", horizontal: "\u2550", cross:     "\u256c",
	              nw_corner: "\u2554", ne_corner:  "\u2557", se_corner: "\u255d",
	              sw_corner: "\u255a", n_divide:   "\u2566", s_divide:  "\u2569",
	              e_divide:  "\u2563", w_divide:   "\u2560" }

end
