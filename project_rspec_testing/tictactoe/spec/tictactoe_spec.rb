# Tests for the Tictactoe class.
# All tests are run through the #play method because it is the only public
# method (besides initialize).  Mocks and stubs are used to help direct and
# check the flow of the game play. All end game conditions are tested and by
# extension the private helper functions that #play uses are checked.
require './lib/tictactoe'

describe TicTacToe do 
	let(:tictactoe) { TicTacToe.new }
	before(:each) do 
		allow(tictactoe).to receive(:puts)
		allow(tictactoe).to receive(:print)
	end

	describe '#play' do 
		after(:each) do
			tictactoe.play
		end

		context 'when one game played' do
			before(:each) do 
				allow(tictactoe).to receive(:play_again?).and_return(false)
			end

			context 'where X wins' do 
				before(:each) do 
					expect(tictactoe).to receive(:game_over?).and_call_original.exactly(5).times
					expect(tictactoe).to receive(:draw?).and_call_original.exactly(4).times
					expect(tictactoe).to receive(:end_game_message).once.with("Player X Won.")
				end

				it 'recognizes horizontal X win' do 
					allow(tictactoe).to receive(:get_valid_move).and_return(0, 3, 1, 4, 2, 5)
				end
				it 'recognizes vertical X win' do 
					allow(tictactoe).to receive(:get_valid_move).and_return(0, 4, 3, 7, 6, 1)
				end
				it 'recognizes diagonal X win' do 
					allow(tictactoe).to receive(:get_valid_move).and_return(0, 3, 4, 7, 8, 1)
				end
			end

			context 'where O wins' do 
				before(:each) do 
					expect(tictactoe).to receive(:game_over?).and_call_original.exactly(6).times
					expect(tictactoe).to receive(:draw?).and_call_original.exactly(5).times
					expect(tictactoe).to receive(:end_game_message).once.with("Player O Won.")
				end

				it 'recognizes horizontal O win' do 
					allow(tictactoe).to receive(:get_valid_move).and_return(0, 3, 1, 4, 6, 5, 7)
				end
				it 'recognizes vertical O win' do 
					allow(tictactoe).to receive(:get_valid_move).and_return(0, 1, 5, 4, 6, 7, 2)
				end
				it 'recognizes diagonal O win' do 
					allow(tictactoe).to receive(:get_valid_move).and_return(0, 2, 3, 4, 8, 6, 1)
				end
			end
			it 'recognizes draw game' do 
				allow(tictactoe).to receive(:get_valid_move).and_return(4, 2, 0, 8, 5, 3, 1, 7, 6)
				expect(tictactoe).to receive(:game_over?).and_call_original.exactly(9).times
				expect(tictactoe).to receive(:draw?).and_call_original.exactly(9).times
				expect(tictactoe).to receive(:end_game_message).once.with("Game Ended in a draw.")
			end
		end

		context 'when multiple games played' do 
			before(:each) do 
				allow(tictactoe).to receive(:play_again?).and_return(true, false)
			end

			it 'recognizes X win in second game' do
				allow(tictactoe).to receive(:get_valid_move).and_return(0, 3, 1, 4, 2, 6, 4, 8, 3, 5, 0, 1, 2, 7)
				expect(tictactoe).to receive(:game_over?).and_call_original.exactly(14).times
				expect(tictactoe).to receive(:draw?).and_call_original.exactly(12).times
				expect(tictactoe).to receive(:end_game_message).twice.with("Player X Won.")
			end
			it 'recognizes O win in second game' do
				allow(tictactoe).to receive(:get_valid_move).and_return(0, 3, 1, 4, 6, 5,    4, 2, 7, 1, 6, 8, 0, 5)
				expect(tictactoe).to receive(:game_over?).and_call_original.exactly(14).times
				expect(tictactoe).to receive(:draw?).and_call_original.exactly(12).times
				expect(tictactoe).to receive(:end_game_message).twice.with("Player O Won.")
			end
			it 'recognizes draw in second game' do
				allow(tictactoe).to receive(:get_valid_move).and_return(4, 2, 0, 8, 5, 3, 1, 7, 6, 0, 4, 8, 3, 5, 7, 1, 2, 6)
				expect(tictactoe).to receive(:game_over?).and_call_original.exactly(18).times
				expect(tictactoe).to receive(:draw?).and_call_original.exactly(18).times
				expect(tictactoe).to receive(:end_game_message).twice.with("Game Ended in a draw.")
			end
		end

	end
end