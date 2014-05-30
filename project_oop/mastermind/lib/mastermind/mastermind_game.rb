# Class to create and run a Mastermind game
class MastermindGame

	# Play as many games of Mastermind as the user wants
	def play
		player_name = get_player_name

		while true
			setup(player_name)
			play_game
			break unless play_again?
		end
		puts "Thanks #{ player_name } for playing Mastermind...Play again soon :-)"
	end

  # *********************************************
  # ************  PRIVATE METHODS  **************
  # *********************************************
	private

	# Play one game of Mastermind
	def play_game
		passes = 0
		while true
			break if game_over?(passes)
			passes += 1
			@board.reset_board
			@board.display_board(@codebreaker.human?)
			secret_code = @codemaker.make_code
			@board.refresh_board(:secret, secret_code, @codebreaker.human?)

			play_turn(secret_code)
			switch_player_roles
		end
		display_game_results
	end

	# Play a turn of Mastermind (as codemaker or codebreaker)
	def play_turn secret_code
		guesses = 0
		@codebreaker.setup if @codebreaker.ai?

		while true
			current_guess = @codebreaker.make_guess
			@codemaker.increase_score
			@board.refresh_board(:decoding, current_guess, @codebreaker.human?, guesses)
			guesses += 1

			break if end_turn?(current_guess, secret_code, guesses)
			handle_rating(current_guess, secret_code, guesses)
		end
		display_end_turn_message
	end

	# Provide brief status at the end of every turn
	def display_end_turn_message
		puts "Current Scores => #{ @codemaker.name }: #{ @codemaker.score } " \
		      "points;\t#{ @codebreaker.name }: #{ @codebreaker.score } points. "
		print "Press Enter to continue..."; gets
	end

	# Rate the guess of the codebreaker
	def handle_rating(current_guess, secret_code, guesses)
		to_rate = @codebreaker.human? ? "your" : "#{ @codebreaker.name }'s"
		print "Press Enter to rate #{ to_rate } guess..."; gets

		rating = Mastermind::rate_guess(current_guess, secret_code)
		# Give the AI feedback about the rating of it's last guess
		@codebreaker.last_rating = rating if @codebreaker.ai?
		@board.refresh_board(:rating, @board.rating_board_data(rating), 
			                   @codebreaker.human?, guesses - 1)
	end

	# Check if an end turn condition has been met
	def end_turn?(current_guess, secret_code, guesses)
		return true if code_guessed?(current_guess, secret_code)
		return true if max_guesses_exceeded?(guesses)
		false
	end

	# Check if the codebreaker has guessed the code
	def code_guessed?(current_guess, secret_code)
		if current_guess == secret_code
			@board.display_board
			puts "#{ @codebreaker.name } got the secret code."
			return true
		end
		false
	end

	# Check if the codebreker has exhausted all guesses
	def max_guesses_exceeded?(guesses)
		if guesses >= Mastermind::MAX_GUESSES
			@codemaker.increase_score
			@board.display_board
			puts "#{ @codebreaker.name } did not get the secret code."
			return true
		end
		false
	end

	# Check if a Mastermind game is over
	def game_over?(passes)
		current_round = (passes / 2) + 1
		if current_round <= @rounds
			puts "\nRound #{ current_round }. #{ @codemaker.name } is the " \
		       "codemaker; #{ @codebreaker.name } is the codebreaker." 
		end
		current_round > @rounds
	end

	# Display final scores and winner (if there is one)
	def display_game_results
		puts "\nFINAL SCORES"
		puts "============"
		puts "#{ @codebreaker.name }: #{ @codebreaker.score } points;\t" \
		     "#{ @codemaker.name }: #{ @codemaker.score } points. "
		if @codebreaker.score == @codemaker.score
			puts Mastermind::color("DRAW game.", "bold")
		else
			winner = [@codebreaker, @codemaker].max_by{ |player| player.score }
			puts Mastermind::color("#{ winner.name } WINS.", "bold")
		end
	end

	# At the end of a turn switch codemaker and codebreaker
	def switch_player_roles
		@codebreaker, @codemaker = @codemaker, @codebreaker
	end

	# Setup for a game of Mastermind
	def setup player_name
		@rounds = get_rounds
		initial_role = get_role(player_name)
		set_roles(initial_role, player_name)
		@board = Board.new
	end

	# Set the initial roles of the players based on the user's input
	def set_roles(initial_role, player_name)
		if initial_role == 'm'
			@codemaker = Player.new(player_name)
			@codebreaker = PlayerAI.new
		else
			@codebreaker = Player.new(player_name)
			@codemaker = PlayerAI.new
		end
	end

	# Get the initial role of the user
	def get_role player_name
		prompt =  "Enter your initial role, codemaker or codebreaker (M/B): "
		while true
			role = Mastermind::get_user_input(prompt)
			case role.strip.downcase
			when 'm', 'codemaker', 'code maker', 'maker' then return 'm'
			when 'b', 'codebreaker', 'code breaker', 'breaker' then return 'b'
			end
		end
	end

	# Get how many rounds will be played in a game of Mastermind
	def get_rounds
		system "clear"
		puts "A round consists of two passes; once with you as codemaker\n" \
			   "and once with you as codebreaker."
		while true
			rounds = Mastermind::get_user_input("Enter number of rounds (1-10): ")
			return rounds.to_i if rounds.to_i.between?(1, 10)
		end
	end

	# Get the user's name. Default to 'Player 1' if no name is provided
	def get_player_name
		player_name = Mastermind::get_user_input("Enter your name: ")
		player_name = "Player 1" if player_name.strip == ""
		player_name
	end

	# Determine if user whats to play another Mastermind game
	def play_again?
		while true
			play_again = Mastermind::get_user_input("Play again (y/n): ")
			case play_again.downcase
			when 'y', 'yes' then return true
			when 'n', 'no' then return false
			end
		end
	end

end
