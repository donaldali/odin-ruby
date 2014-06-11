# Class to display the board of a Connect Four game
class Board	
	ROWS, COLS = 6, 7
	PIECE = "\u2b24"
	ARROW = "\u2b07"

	attr_reader :board
	
	def initialize
		clear_board
	end

	# Makes a COLS by ROWS board full of blank game pieces
	def clear_board
		@board = []
		COLS.times do 
			blank_col = []
			ROWS.times { blank_col << :blank }
			@board << blank_col
		end
	end

  # Place a game piece in a specified column if that column has at least
  # a blank space; nil is returned if not blank space exists 
	def place_piece_in_column(piece, col)
		first_blank_index = @board[col].index(:blank)
		return nil if first_blank_index.nil?
		@board[col][first_blank_index] = piece
	end

  # Display the game board
	def display_board
		puts "Choose column to place a piece by the numbers below"
		puts "\t" + " 1   2   3   4   5   6   7"
		puts "\t" + (" #{ARROW}  " * COLS)

		(ROWS - 1).downto(0) do |row|
			print "\t"
			0.upto(COLS - 1) { |col| print color(" #{PIECE}  ", @board[col][row]) }
			puts "\n\t" + color(" " * (4 * COLS), :blank)
		end
	end

  # Color is expected as a symbol. Eg :yellow or :red
	def color(text, color)
		case color
		when :red then colorize(text, "1;31;44")
		when :yellow then colorize(text, "1;33;44")
		when :flip then colorize(text, "7")
		when :blank then colorize(text, "1;34;44")
		else colorize(text, "0")
		end
	end

	# Color code is expected. Eg "1;34;44"
	def colorize(text, color_code)
		"\033[#{color_code}m#{text}\033[0m"
	end

end
