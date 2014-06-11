# Class to play the connect four game
class ConnectFourGame
	PLAYERS = [:red, :yellow]

	attr_reader :gameboard, :cur_player, :winner

	def initialize
		@gameboard = Board.new
		initialize_game
	end

  # Set up the game state for a new game
	def initialize_game
		@gameboard.clear_board
		@cur_player = PLAYERS.first
		@winner = nil
	end

  # Play several games of Connect Four
	def play
		display_welcome_message
		loop do
			initialize_game
			play_game
			break unless play_again?
		end
		display_goodbye_message
	end

  # Play a game of Connect Four
	def play_game
		loop do
			@gameboard.display_board
			@gameboard.place_piece_in_column(@cur_player, get_valid_input)
			break if game_over?
			switch_player
		end
		@gameboard.display_board
		display_endgame_message
	end

	def display_welcome_message
		puts "\n\t*************************************"
		puts "\t*****  Welcome to Connect Four  *****"
		puts "\t*************************************\n\n"
	end

	def display_goodbye_message
		puts "\nThanks for playing Connect Four. Come back soon :-)"
	end

  # Format and display message declaring winner (or a draw)
	def display_endgame_message
		puts @gameboard.color(@winner == :draw ? "\n\tGame ended in a draw." : 
		                        "\n\t#{@winner.to_s.capitalize} player WON!", :flip)
	end

  # Set current player to the other player
	def switch_player
		@cur_player = PLAYERS.reject { |player| player == @cur_player }.first
	end

  # Get input from user based on a given prompt
	def get_input_for_prompt prompt 
		loop do 
			print prompt + ": "
			input  = gets.chomp
			return input unless input.empty?
		end
	end

  # Check if a value can be played on the game board. Input entered is
  # one_indexed
	def valid_input? input
		input_int = input.to_i
		return false unless input_int.between?(1, Board::COLS)
		unless @gameboard.board[input_int - 1][Board::ROWS - 1] == :blank
			puts "Column #{input.strip} is full; please choose another column."
			return false
		end
		true
	end

  # This method reduces the value of a valid input by one
  # to match the index of the board
	def get_valid_input
		loop do
			prompt = "#{@cur_player.to_s.capitalize} player, Enter column to play in (1-#{Board::COLS})"
			input = get_input_for_prompt prompt
			return input.to_i - 1 if valid_input?(input)
		end
	end

  # Determine if another game will be played
	def play_again?
		loop do
			play_again = get_input_for_prompt "Play another game (y/n)"
			case play_again.strip.downcase
			when 'n', 'no' then return false
			when 'y', 'yes' then return true
			end
		end
	end

  # Check if a game has ended
	def game_over?
		return true if horizontal_win?
		return true if vertical_win?
		return true if diagonal_win?
		return draw?
	end

  # Check if a player has 4 horizontal pieces
	def horizontal_win?
		check_board_section(0, Board::COLS - 4, 0, Board::ROWS - 1, [1, 0])
	end

  # Check if a player has 4 vertical pieces
	def vertical_win?
		check_board_section(0, Board::COLS - 1, 0, Board::ROWS - 4, [0, 1])
	end

  # Check if a player has 4 diagonal pieces
	def diagonal_win?
		return true if ne_diagonal_win?
		return true if nw_diagonal_win?
		false
	end

  # Check if game has ended in a draw
	def draw?
		top_cell = @gameboard.board.map { |col| col[Board::ROWS - 1] }
		if top_cell.none? { |cell| cell == :blank }
			@winner = :draw
			true
		else
			false
		end
	end

  # Check if a player has 4 diagonal pieces in a north-east direction
	def ne_diagonal_win?
		check_board_section(0, Board::COLS - 4, 0, Board::ROWS - 4, [1, 1])
	end

  # Check if a player has 4 diagonal pieces in a north-west direction
	def nw_diagonal_win?
		check_board_section(3, Board::COLS - 1, 0, Board::ROWS - 4, [-1, 1])
	end

  # Determine if a section of the gameboard has 4 consecutive pieces in a given
  # direction (with the aid of the helper methods)
	def check_board_section(start_col, end_col, start_row, end_row, position_change)
		(start_col..end_col).each do |col|
			(start_row..end_row).each do |row|
				if same_piece_at_positions(consecutive_positions([col, row], position_change))
					@winner = @gameboard.board[col][row]
					return true
				end
			end
		end
		false
	end

  # Determine 4 consecutive positions from a starting position in a given direction
	def consecutive_positions(start_position, position_change)
		positions = [start_position]
		3.times { positions << add_positions(positions.last, position_change) }
		positions
	end

  # Add the row and col values of two positions
	def add_positions(position1, position2)
		[position1[0] + position2[0], position1[1] + position2[1]]
	end

  # Determine if all pieces in a number of positions belong to only one player
	def same_piece_at_positions(piece_positions)
		pieces = piece_positions.map { |pos| @gameboard.board[pos.first][pos.last] }
		return if pieces.first == :blank
		pieces.uniq.length == 1		
	end

end
