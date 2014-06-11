require 'spec_helper'

describe Board do 
	let(:gameboard) { Board.new }

	describe '#new' do 
		it 'creates an instance of Board' do
			expect(gameboard).to be_instance_of(Board)
		end
	end

	describe '#clear_board' do 
		it "makes board have #{Board::COLS} columns" do 
			expect(gameboard.board.length).to eq(Board::COLS)
		end
		it "makes columns of length #{Board::ROWS}" do 
			gameboard.board.each do |col|
				expect(col.length).to eq(Board::ROWS)
			end
		end
		it "makes all cells of board blank" do 
			gameboard.board.each do |col|
				col.each do |cell|
					expect(cell).to eq(:blank)
				end
			end
		end
	end

	describe '#place_piece_in_column' do 
		before(:each) do 
			(Board::ROWS - 1).times { gameboard.place_piece_in_column(:red, 1) }
		end
		it 'places piece in an empty column' do 
			expect(gameboard.board[2][0]).to eq(:blank)
			gameboard.place_piece_in_column(:red, 2)
			expect(gameboard.board[2][0]).to eq(:red)
		end
		it 'places piece in partly full column' do 
			expect(gameboard.board[1][5]).to eq(:blank)
			gameboard.place_piece_in_column(:red, 1)
			expect(gameboard.board[1][5]).to eq(:red)
		end
		it 'does not place piece in full column' do 
			gameboard.place_piece_in_column(:red, 1)
			expect(gameboard.board[1][5]).to eq(:red)
			expect(gameboard.place_piece_in_column(:yellow, 1)).to be_nil
		end
	end

end
