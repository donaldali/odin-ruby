require 'spec_helper'

describe ConnectFourGame do
	let(:connect_four_game) { ConnectFourGame.new }
	let(:player1) { ConnectFourGame::PLAYERS.first }
	let(:player2) { ConnectFourGame::PLAYERS.last }

	before(:each) do
		allow(connect_four_game).to receive(:puts)
		allow(connect_four_game).to receive(:print)
		allow(connect_four_game.gameboard).to receive(:display_board)
	end

	describe '#new' do
		it 'creates a new game board' do
			expect(connect_four_game.gameboard).to be_instance_of(Board)
		end
		it "sets current player to #{ConnectFourGame::PLAYERS.first}" do 
			expect(connect_four_game.cur_player).to eq(player1)
		end
		it 'sets winner to nil' do
			expect(connect_four_game.winner).to be_nil
		end
	end

	describe '#switch_player' do
		it "switches from #{ConnectFourGame::PLAYERS.first} player to #{ConnectFourGame::PLAYERS.last}" do
			expect(connect_four_game.cur_player).to eq(player1)
			connect_four_game.switch_player
			expect(connect_four_game.cur_player).to eq(player2)
		end
		it "switches from #{ConnectFourGame::PLAYERS.last} player to #{ConnectFourGame::PLAYERS.first}" do
			connect_four_game.switch_player
			expect(connect_four_game.cur_player).to eq(player2)
			connect_four_game.switch_player
			expect(connect_four_game.cur_player).to eq(player1)
		end
	end

	describe '#get_input_for_prompt' do
		it 'does not accept an empty input' do
			allow(connect_four_game).to receive(:gets).and_return("", "", "2", "3")
			expect(connect_four_game.get_input_for_prompt("Input")).to eq("2")
		end
		it 'accepts and returns every other input' do 
			allow(connect_four_game).to receive(:gets).and_return("yes", "no")
			expect(connect_four_game.get_input_for_prompt("Input")).to eq("yes")
		end
	end

	describe '#valid_input?' do 
		it 'rejects non-numeric inputs' do
			expect(connect_four_game.valid_input?("string")).to be_false
		end
		it 'rejects non-positive numbers' do 
			expect(connect_four_game.valid_input?("0")).to be_false
			expect(connect_four_game.valid_input?("-1")).to be_false
		end
		it "rejects numbers above #{Board::COLS}" do
			expect(connect_four_game.valid_input?("#{Board::COLS + 1}")).to be_false
		end
		# Note that place_piece_in_column is zero indexed; valid_input? is one indexed
		it 'rejects numbers representing a full column' do
			Board::ROWS.times { connect_four_game.gameboard.place_piece_in_column(connect_four_game.cur_player, 1) }
			expect(connect_four_game.valid_input?("2")).to be_false
		end
		it "accepts numbers in range 1..#{Board::COLS}" do
			expect(connect_four_game.valid_input?("1")).to be_true
			expect(connect_four_game.valid_input?("#{Board::COLS}")).to be_true
		end
	end

  # Note that this method reduces the value of a valid input by one
  # to match the index of the board
	describe '#get_valid_input' do 
		it 'does not accept invalid input' do 
			allow(connect_four_game).to receive(:get_input_for_prompt).
			                         and_return("wrong", 0, -1, Board::COLS + 1, 2)
			expect(connect_four_game.get_valid_input).to eq(1)
		end
		it 'accepts valid numeric input' do 
			allow(connect_four_game).to receive(:get_input_for_prompt).
			                         and_return(Board::COLS)
			expect(connect_four_game.get_valid_input).to eq(Board::COLS - 1)
		end
	end

	describe '#play_again?' do
		it 'returns true when user enters "y"' do 
			allow(connect_four_game).to receive(:gets).and_return('y')
			expect(connect_four_game.play_again?).to be_true
		end
		it 'returns true when user enters "yes"' do 
			allow(connect_four_game).to receive(:gets).and_return('yes')
			expect(connect_four_game.play_again?).to be_true
		end
		it 'returns false when user enters "n"' do 
			allow(connect_four_game).to receive(:gets).and_return('n')
			expect(connect_four_game.play_again?).to be_false
		end
		it 'returns false when user enters "no"' do 
			allow(connect_four_game).to receive(:gets).and_return('no')
			expect(connect_four_game.play_again?).to be_false
		end
		it 'ignores other responses' do 
			allow(connect_four_game).to receive(:gets).and_return('yea', 'nay', 'n')
			expect(connect_four_game.play_again?).to be_false
		end
	end

	describe '#game_over?' do
    # Set positions in an array of positions to piece
		def set_board(positions, piece)
			positions.each do |position|
				connect_four_game.gameboard.board[position[0]][position[1]] = piece
			end
		end

		context 'when 4 similar pieces occur horizontally' do
			(0..Board::COLS - 4).each do |col|
				(0..Board::ROWS - 1).each do |row|
					it "recognizes #{ConnectFourGame::PLAYERS.first} win from [#{col}, #{row}] rightward" do
						set_board([ [col, row], [col + 1, row], [col + 2, row], 
							          [col + 3, row] ], player1)
						expect(connect_four_game.game_over?).to be_true
						expect(connect_four_game.winner).to eq(player1)
					end
					it "recognizes #{ConnectFourGame::PLAYERS.last} win from [#{col}, #{row}] rightward" do
						set_board([ [col, row], [col + 1, row], [col + 2, row], 
							          [col + 3, row] ], player2)
						expect(connect_four_game.game_over?).to be_true
						expect(connect_four_game.winner).to eq(player2)
					end
				end
			end
		end

		context 'when 4 similar pieces occur vertically' do
			(0..Board::COLS - 1).each do |col|
				(0..Board::ROWS - 4).each do |row|
					it "recognizes #{ConnectFourGame::PLAYERS.first} win from [#{col}, #{row}] upward" do
						set_board([ [col, row], [col, row + 1], [col, row + 2], 
							          [col, row + 3] ], player1)
						expect(connect_four_game.game_over?).to be_true
						expect(connect_four_game.winner).to eq(player1)
					end
					it "recognizes #{ConnectFourGame::PLAYERS.last} win from [#{col}, #{row}] upward" do
						set_board([ [col, row], [col, row + 1], [col, row + 2], 
							          [col, row + 3] ], player2)
						expect(connect_four_game.game_over?).to be_true
						expect(connect_four_game.winner).to eq(player2)
					end
				end
			end
		end

		context 'when 4 similar pieces occur diagonally' do
			(0..Board::COLS - 4).each do |col|
				(0..Board::ROWS - 4).each do |row|
					it "recognizes #{ConnectFourGame::PLAYERS.first} win from [#{col}, #{row}] northeastward" do
						set_board([ [col, row], [col + 1, row + 1], [col + 2, row + 2], 
							          [col + 3, row + 3] ], player1)
						expect(connect_four_game.game_over?).to be_true
						expect(connect_four_game.winner).to eq(player1)
					end
					it "recognizes #{ConnectFourGame::PLAYERS.last} win from [#{col}, #{row}] northeastward" do
						set_board([ [col, row], [col + 1, row + 1], [col + 2, row + 2], 
							          [col + 3, row + 3] ], player2)
						expect(connect_four_game.game_over?).to be_true
						expect(connect_four_game.winner).to eq(player2)
					end
				end
			end
			(3..Board::COLS - 1).each do |col|
				(0..Board::ROWS - 4).each do |row|
					it "recognizes #{ConnectFourGame::PLAYERS.first} win from [#{col}, #{row}] northwestward" do
						set_board([ [col, row], [col - 1, row + 1], [col - 2, row + 2], 
							          [col - 3, row + 3] ], player1)
						expect(connect_four_game.game_over?).to be_true
						expect(connect_four_game.winner).to eq(player1)
					end
					it "recognizes #{ConnectFourGame::PLAYERS.last} win from [#{col}, #{row}] northwestward" do
						set_board([ [col, row], [col - 1, row + 1], [col - 2, row + 2], 
							          [col - 3, row + 3] ], player2)
						expect(connect_four_game.game_over?).to be_true
						expect(connect_four_game.winner).to eq(player2)
					end
				end
			end
		end

		context 'when game ends in a draw' do
			it 'recognizes the draw' do
				count = 0
				(0..Board::COLS - 1).each do |col|
					(0..Board::ROWS - 1).each do |row|
						connect_four_game.gameboard.board[col][row] = connect_four_game.cur_player
						count += 1
						connect_four_game.switch_player if count.even?
					end
				end
				connect_four_game.gameboard.board[0][Board::ROWS - 1] = :blank
				expect(connect_four_game.game_over?).to be_false
				connect_four_game.gameboard.board[0][Board::ROWS - 1] = player1
				expect(connect_four_game.game_over?).to be_true
				expect(connect_four_game.winner).to eq(:draw)			
			end
		end

	end

	describe '#play_game' do
		before(:each) do
			allow(connect_four_game).to receive(:play_again?).and_return(false)
			expect(connect_four_game).to receive(:play_game).and_call_original
		end

		it "allow #{ConnectFourGame::PLAYERS.first} player to win a game" do
			allow(connect_four_game).to receive(:get_valid_input).and_return(1, 2, 1, 2, 1, 2, 1, 2, 1)
			expect(connect_four_game).to receive(:game_over?).and_call_original.exactly(7).times
			connect_four_game.play_game
			expect(connect_four_game.winner).to eq(player1)
		end
		it "allow #{ConnectFourGame::PLAYERS.last} player to win a game" do
			allow(connect_four_game).to receive(:get_valid_input).and_return(1, 2, 1, 2, 1, 2, 3, 2, 3)
			expect(connect_four_game).to receive(:game_over?).and_call_original.exactly(8).times
			connect_four_game.play_game
			expect(connect_four_game.winner).to eq(player2)
		end
		it "allow a draw game" do
			allow(connect_four_game).to receive(:get_valid_input).
			                         and_return(0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 
			                         	          2, 3, 2, 3, 3, 2, 3, 2, 2, 3, 2, 3, 
			                         	          4, 5, 4, 5, 5, 4, 5, 4, 4, 5, 4, 5, 
			                         	          6, 6, 6, 6, 6, 6)
			expect(connect_four_game).to receive(:game_over?).and_call_original.exactly(42).times
			connect_four_game.play_game
			expect(connect_four_game.winner).to eq(:draw)
		end
	end

  describe '#play' do
  	it 'allows multiple games to be played' do
  		allow(connect_four_game).to receive(:play).and_call_original
  		allow(connect_four_game).to receive(:play_again?).and_return(true, false)
  		allow(connect_four_game).to receive(:get_valid_input).
		                           and_return(1, 6, 2, 6, 3, 6, 4, 
			                         	          2, 1, 3, 2, 3, 3, 4, 4, 4, 4)
	    expect(connect_four_game).to receive(:game_over?).and_call_original.exactly(17).times
	    expect(connect_four_game).to receive(:play_game).and_call_original.exactly(2).times
	    connect_four_game.play
	    expect(connect_four_game.winner).to eq(player2)
	  end
	end


	describe '#initialize_game' do
		before(:each) do
			allow(connect_four_game).to receive(:play_again?).and_return(false)
			allow(connect_four_game).to receive(:get_valid_input).and_return(1, 2, 1, 2, 1, 2, 3, 2)
			connect_four_game.play_game
		end
		it 'clears the gameboard' do
			expect(connect_four_game.gameboard.board[1][0]).to eq(player1)
			connect_four_game.initialize_game
			expect(connect_four_game.gameboard.board[1][0]).to eq(:blank)
		end
		it "sets current player to #{ConnectFourGame::PLAYERS.first}" do 
			expect(connect_four_game.cur_player).to eq(player2)
			connect_four_game.initialize_game
			expect(connect_four_game.cur_player).to eq(player1)
		end
		it 'sets winner to nil' do
			expect(connect_four_game.winner).to eq(player2)
			connect_four_game.initialize_game
			expect(connect_four_game.winner).to be_nil
		end
	end

end
