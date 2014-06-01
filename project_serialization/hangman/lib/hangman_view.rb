# View helper to display the hangman figure and game status
class HangmanView

	# Display the hangman figure and game state next to the figure
	def display_game_state(word, misses, hits, guesses_left)
		puts
		HANGMAN_FIGURE.each_with_index do |row, index|
			row.each do |piece|
				if piece[:visible] >= guesses_left
					print piece[:piece] 
				else
					print PIECES[:space]
				end
			end
			show_game_status(index, word, misses, hits, guesses_left)
		end
	end

  # *********************************************
  # ************  PRIVATE METHODS  **************
  # *********************************************
	private

	# Display state of the game next to the hangman figure
	def show_game_status(output_row, word, misses, hits, guesses_left)
		case output_row
		when 0 then puts "\tWord            : #{ word_hint(word, hits) }"
		when 1 then puts "\tMisses          : #{ misses.join(',') }"
		when 2 then puts "\tCorrect guesses : #{ hits.join(',') }"
		when 3 then puts "\tGuesses left    : #{ guesses_left }"
		when 4 then print "\tEnter next guess ('save' to save game): "
		end
	end

	# Display the letters of the word that have been guessed
	def word_hint(word, hits)
		hint_string = ""
		word.each_char { |char| hint_string += hits.include?(char) ? char : "_" }
		hint_string
	end

	PIECES = { horizontal: "\u2501", vertical:  "\u2503", nw_corner: "\u250f", 
		         ne_corner:  "\u2511", head:      "\u2d54", left_arm:  "\u2571",
		         right_arm:  "\u2572", right_leg: " \u20e5", left_leg:  " \u0338", 
		         space:      " ", horizontal_vertical: "\u253b",  }
	HANGMAN_FIGURE = 
	  [ [ { piece: PIECES[:space],      visible: 10 }, { piece: PIECES[:nw_corner],           visible: 7 }, 
	      { piece: PIECES[:horizontal], visible: 7 },  { piece: PIECES[:horizontal],          visible: 7 }, 
	      { piece: PIECES[:ne_corner],  visible: 6 },  { piece: PIECES[:space],               visible: 10 } ],
	    [ { piece: PIECES[:space],      visible: 10 }, { piece: PIECES[:vertical],            visible: 8 }, 
	      { piece: PIECES[:space],      visible: 10 }, { piece: PIECES[:space],               visible: 10 }, 
	      { piece: PIECES[:head],       visible: 5 },  { piece: PIECES[:space],               visible: 10 } ],
	    [ { piece: PIECES[:space],      visible: 10 }, { piece: PIECES[:vertical],            visible: 8 }, 
	      { piece: PIECES[:space],      visible: 10 }, { piece: PIECES[:left_arm],            visible: 3 }, 
	      { piece: PIECES[:vertical],   visible: 4 },  { piece: PIECES[:right_arm],           visible: 2 } ],
	    [ { piece: PIECES[:space],      visible: 10 }, { piece: PIECES[:vertical],            visible: 8 }, 
	      { piece: PIECES[:space],      visible: 10 }, { piece: PIECES[:space],               visible: 10 }, 
	      { piece: PIECES[:left_leg],   visible: 1 },  { piece: PIECES[:right_leg],           visible: 0 } ],
	    [ { piece: PIECES[:horizontal], visible: 9 },  { piece: PIECES[:horizontal_vertical], visible: 9 }, 
	      { piece: PIECES[:horizontal], visible: 9 },  { piece: PIECES[:horizontal],          visible: 9 }, 
	      { piece: PIECES[:horizontal], visible: 9 },  { piece: PIECES[:horizontal],          visible: 9 } ] 
	  ]
end
