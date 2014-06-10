require './lib/caesar_cipher'

describe "caesar_cipher" do 
	it "shifts input by given factor" do 
		expect(caesar_cipher("caesar", 3)).to eq("fdhvdu")
	end
	it "handles shifts over 26" do 
		expect(caesar_cipher("caesar", 264)).to eq("geiwev")
	end
	it "handles a shift of zero" do 
		expect(caesar_cipher("caesar", 0)).to eq("caesar")
	end
	it "retains capitalization of input" do 
		expect(caesar_cipher("Caesar", 3)).to eq("Fdhvdu")
	end
	it "wraps characters past 'z'" do 
		expect(caesar_cipher("caesar", 10)).to eq("mkockb")
	end
	it "doesn't shift non-alphabet characters" do 
		expect(caesar_cipher("caesar, CAESAR!", 3)).to eq("fdhvdu, FDHVDU!")
	end
end
