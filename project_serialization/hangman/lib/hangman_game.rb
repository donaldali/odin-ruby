# Class to play the Hangman game
class HangmanGame

	# Setup the view and attributes
	def initialize
		@view = HangmanView.new
		setup_game
	end

	# Play Hangman from initial options
	def play
		display_welcome
		while true
			choice = get_menu_choice
			choice_result = handle_menu_choice choice
			break if choice_result == :quit
		end
		puts "Thanks for playing Hangman :-) Play again soon."
	end

  # *********************************************
  # ***********  PROTECTED METHODS  *************
  # *********************************************
	protected

	# Play a game of hangman (offering the opportunity to save the game)
	def play_game
  	while true
  		@view.display_game_state(@word, @misses, @hits, @guesses_left)
  		break if game_over?
  		guess = get_guess
  		break if guess == :save
  		update_game_state guess
  	end
  	save_game if guess == :save
	end

  # *********************************************
  # ************  PRIVATE METHODS  **************
  # *********************************************
	private

	# One time welcome message
	def display_welcome
		puts "\t**************************"
		puts "\t*** Welcome To Hangman ***"
		puts "\t**************************"
	end

	# Display main menu and get user's choice
	def get_menu_choice
		choices = ["1. Play Hangman", "2. Load Saved Game", "3. Delete Saved Game",
			"4. List Saved Games", "5. Quit"]
		display_menu choices

		while true
			print "Enter Selection (1 - #{ choices.length }): "
			choice = gets.chomp.to_i
			return choice if choice.between?(1, choices.length)
		end
	end

	# Display the main menu
	def display_menu choices
		menu_array = ["\nHangman Options", "==============="] + choices
		menu_array.each { |menu| puts menu }		
	end

	# Controller that calls the appropriate method based on the user's choice
	def handle_menu_choice choice
		case choice
		when 1 then setup_game; play_game
		when 2 then load_game
		when 3 then delete_game
		when 4 then list_games
		when 5 then return :quit
		end
	end

	# Intialize instance variables for a new game of Hangman
	def setup_game
		@word = get_word.upcase
		@misses = []
		@hits = []
		@guesses_left = 10
	end

	# Get a random word to be guessed during the Hangman game
	def get_word
		begin
		  File.readlines(DICTIONARY_FILENAME).
		     select { |word| word.length.between?(6, 13) }.sample.chomp
		rescue
			puts "Unable to read from file '#{ DICTIONARY_FILENAME }'."
			nil
		end
	end

	# Check if a game is over
	def game_over?
		if @guesses_left <= 0
			message_then_enter "\nSorry. No more guesses left."\
			                    " The word was '#{ @word.capitalize }'."
			true
		elsif @word.split('').uniq.length == @hits.length
			message_then_enter "\nCongratulations...You got the word."
			true
		else
			false
		end			
	end

	# After a guess is made, make appropriate changes to the game state
	def update_game_state guess
		if @word.include?(guess)
			@hits << guess
		else
			@misses << guess
			@guesses_left -= 1
		end
	end

	# Get guess from the player (one letter) or 'save' to save the game
	def get_guess
		while true
			guess = gets.chomp.upcase
			return :save if guess == "SAVE" || guess == "'SAVE'"
			if guess.between?('A', 'Z') && guess.length == 1
				if @hits.include?(guess) || @misses.include?(guess)
					print "You guessed '#{ guess }' already. Select another letter: "
					next
				end
				return guess
			end
			print "Enter one letter for guess (or 'save' to save game): "
		end
	end

	# Load a previously saved game and resume game play from last save
	def load_game
		all_saved_games = yaml_load(SAVED_FILENAME)
		game_name = get_game_name(all_saved_games, "load")
		return if game_name.nil?

		saved_game = YAML::load(all_saved_games[game_name])
		message_then_enter "'#{ game_name }' successfully loaded."
		saved_game.play_game
	end

	# Get the name of a game (to load or delete) from the user
	def get_game_name(all_saved_games, task)
		game_names = all_saved_games.keys

		while true
			print "Enter name of game to #{ task }: "
			game_name = gets.chomp
			return game_name if game_names.include? game_name

			next if yes_or_no "'#{ game_name }' doesn't exists; #{ task } another game"

			message_then_enter "You chose to not #{ task } any game."
			return nil
		end
	end

	# Delete a previously saved game
	def delete_game
		all_saved_games = yaml_load(SAVED_FILENAME)
		game_name = get_game_name(all_saved_games, "delete")
		return if game_name.nil?

		all_saved_games.delete(game_name)
		yaml_save(SAVED_FILENAME, all_saved_games)
		message_then_enter "'#{ game_name }' successfully deleted."
	end

	# Save a game in progress
	def save_game
		all_saved_games = yaml_load(SAVED_FILENAME)
		game_name = get_save_name(all_saved_games)
		return if game_name.nil?

		game_string = self.to_yaml
		all_saved_games[game_name] = game_string
		yaml_save(SAVED_FILENAME, all_saved_games)
		message_then_enter "'#{ game_name }' successfully saved."
	end

	# Get the name that the game in progress will be saved as
	def get_save_name all_saved_games
		game_names = all_saved_games.keys

		while true
			print "Enter name to save game as: "
			game_name = gets.chomp
			next if game_name == ""
			return game_name unless game_names.include? game_name

			return game_name if yes_or_no "'#{ game_name }' already exists. Overwrite it"
			next if yes_or_no "Save game with a different name"

			message_then_enter "You chose to not save this game."
			return nil
		end
	end

	# List the names of all previously saved games
	def list_games
		all_saved_games = yaml_load(SAVED_FILENAME)
		game_string = "Saved Games\n===========\n"
		all_saved_games.keys.each { |game_name| game_string += "#{ game_name }\n"}
		message_then_enter game_string
	end

	# Load the contents of a file and convert it to an object with YAML
	def yaml_load(filename)
		begin
		  YAML::load(File.read filename)
		rescue
			puts "Unable to read from file '#{ filename }'."
			nil
		end
	end

	# Use YAML to save an object to file
	def yaml_save(filename, to_save)
		begin
			File.open(filename, 'w') do |file|
				file.write(to_save.to_yaml)
			end
			true
		rescue
			puts "Unable to save to file '#{ filename }'."
			nil
		end
	end

	# Return boolean response to a yes/no question from the user
	def yes_or_no(question)
		while true
			print (question + " (y/n): ")
			response = gets.chomp.strip.downcase
			if response == 'y' || response == 'yes'
				return true
			elsif response == 'n' || response == 'no'
				return false
			end
		end
	end

	# Display a message to the user and wait for user input to continue
	def message_then_enter(message)
		print(message += "\nPress Enter to continue...")
		gets
	end

	SAVED_FILENAME = 'saved_games'
	DICTIONARY_FILENAME = 'dictionary.txt'
end
