# AI to play the Mastermind game. Algorithm used for the AI is based on,
# but not exactly, Donald Knuth's Five-guess algorithm
class PlayerAI < Player
	attr_writer :last_rating

	def initialize(difficulty = :medium)
		ai = ["ENIAC", "HAL 9000", "Deep Thought", "Doctor", "Skynet", 
			    "The Matrix", "Mother", "KITT", "Holly", "Prometheus"]
		super(ai.sample)
	end

	# Randomly choose a code for the human player to guess
	def make_code
		code = []
		print "Press Enter to generate #{ name }'s secret code..."; gets
		Mastermind::BOARD_WIDTH.times {	code << rand(6) + 1 }
		puts "Secret code generated...Begin guessing, human"
		code
	end

	# This method is based on Donald Knuth's Five-guess algorithm
	# (http://en.wikipedia.org/wiki/Mastermind_(board_game)#Algorithms)
	# but due to the computationally expensive step 6 in the wikipedia
	# article, this method randomly selects a possible code after the
	# fifth step.  The performance of this AI is still close to that
	# of the full Five-guess algorithm
	def make_guess
		print "Press Enter to generate #{ name }'s next guess..."; gets
		return handle_first_guess if @first_guess
		update_possible_codes
		@last_guess = @possible_codes.sample
	end

	# Setup the AI to begin guessing
	def setup
		@first_guess = true
		generate_possible_codes
	end

	def human?
		false
	end

	def ai?
		true
	end

  # *********************************************
  # ************  PRIVATE METHODS  **************
  # *********************************************
	private

	# Select only the codes that could have produced the rating feedback
	# received for the AI's last guess
	def update_possible_codes
		@possible_codes.select! do |code|
			Mastermind.rate_guess(code, @last_guess) == @last_rating
		end
	end

	# Select a random code for the first guess
	def handle_first_guess
		@first_guess = false
		@last_guess = @possible_codes.sample
	end

	# Generate all possible codes
	def generate_possible_codes
		@possible_codes = []
		(1..6).each do |color1|
			(1..6).each do |color2|
				(1..6).each do |color3|
					(1..6).each do |color4|
						@possible_codes << [color1, color2, color3, color4]
					end
				end
			end			
		end
	end

end
