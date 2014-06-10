require './lib/enumerable_methods'

describe Enumerable do 
	subject { [1, 2, 3, 4, 5] }

	describe '#my_select' do 
		context 'when block is always true' do 
			it 'returns original enumerable' do 
				expect(subject.my_select { |ele| ele > 0 }).to eq(subject)
			end
		end
		context 'when block is always false' do 
			it 'returns empty enumerable' do 
				expect(subject.my_select { |ele| ele > 10 }).to be_empty
			end
		end
		context 'when enumerable is empty' do 
			it 'returns empty enumerable' do 
				expect([].my_select { |ele| true }).to be_empty
			end
		end
		it 'selects appropriate elements' do 
			expect(subject.my_select { |ele| ele.even? }).to eq([2,4])
		end
	end

	describe '#my_all?' do 
		context 'when block is always true' do 
			it 'returns true' do 
				expect(subject.my_all? { |ele| ele > 0 }).to be_true
			end
		end
		context 'when block is always false' do 
			it 'returns false' do 
				expect(subject.my_all? { |ele| ele > 10 }).to be_false
			end
		end
		context 'when block is sometimes true' do 
			it 'returns false' do 
				expect(subject.my_all? { |ele| ele > 3 }).to be_false
			end
		end
		context 'when enumerable is empty' do 
			it 'returns true' do 
				expect([].my_all? { |ele| false }).to be_true
			end
		end
	end

	describe '#my_any?' do 
		context 'when block is always true' do 
			it 'returns true' do 
				expect(subject.my_any? { |ele| ele > 0 }).to be_true
			end
		end
		context 'when block is always false' do 
			it 'returns false' do 
				expect(subject.my_any? { |ele| ele > 10 }).to be_false
			end
		end
		context 'when block is sometimes true' do 
			it 'returns true' do 
				expect(subject.my_any? { |ele| ele > 3 }).to be_true
			end
		end
		context 'when enumerable is empty' do 
			it 'returns false' do 
				expect([].my_any? { |ele| true }).to be_false
			end
		end
	end

	describe '#my_none?' do 
		context 'when block is always true' do 
			it 'returns false' do 
				expect(subject.my_none? { |ele| ele > 0 }).to be_false
			end
		end
		context 'when block is always false' do 
			it 'returns true' do 
				expect(subject.my_none? { |ele| ele > 10 }).to be_true
			end
		end
		context 'when block is sometimes true' do 
			it 'returns false' do 
				expect(subject.my_none? { |ele| ele > 3 }).to be_false
			end
		end
		context 'when enumerable is empty' do 
			it 'returns true' do 
				expect([].my_none? { |ele| false }).to be_true
			end
		end
	end

	describe '#my_count' do 
		context 'when no block given' do 
			it 'returns size of enumerable' do
				expect(subject.my_count).to eq(5)
			end
			it 'returns zero for empty enumerable' do 
				expect([].my_count).to be_zero
			end
		end

		context 'when block is given' do 
			context 'and block is always true' do 
				it 'returns size of enumerable' do 
					expect(subject.my_count { |ele| ele > 0 }).to eq(5)
				end
			end
			context 'and block is always false' do 
				it 'returns zero' do 
					expect(subject.my_count { |ele| ele > 10 }).to be_zero
				end
			end
			context 'and block is sometimes true' do 
				it 'returns number of times block is true' do 
					expect(subject.my_count { |ele| ele > 3 }).to eq(2)
				end
			end
			context 'and enumerable is empty' do 
				it 'returns zero' do 
					expect([].my_count { |ele| true }).to be_zero
				end
			end
		end
	end

	describe '#my_map' do 
		context 'when enumerable is empty' do 
			it 'returns an empty enumerable' do 
				expect([].my_map { |ele| ele * 2 }).to be_empty
			end
		end
		context "when enumerable isn't empty" do 
			it 'returns mapped enumerable' do 
				expect(subject.my_map { |ele| ele * 2 }).to eq([2, 4, 6, 8, 10])
			end
			it 'does not change original enumerable' do 
				original = [1, 2, 3, 4, 5]
				subject.my_map { |ele| ele * 2 }
				expect(subject).to eq(original)
			end
		end
	end
	
end
