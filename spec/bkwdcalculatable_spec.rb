require './bkwdcalculatable'
require './enigma'

RSpec.describe BkwdCalculatable do
  enigma = Enigma.new

  it '#align_to_shift rotates the last 4 chars of cyphertext to be in shift order' do
    enigma = Enigma.new
    cyphertext = "vjqtbeaweqihssi"
    expected = {
                cyphertext_final_four: ["s", "s", "i", "h"],
                known_end: ["e", "n", "d", " "]
                }

    expect(enigma.align_to_shift(cyphertext)).to eq(expected)
  end

  it '#bkwd_calculate_shifts returns the shifts based on cyphertext and a date' do
    enigma = Enigma.new
    cyphertext = "vjqtbeaweqihssi"
    expected = {A: 14, B: 86%27, C: 32%27, D:8}

    expect(enigma.bkwd_calculate_shifts(cyphertext)).to eq(expected)
  end


end
