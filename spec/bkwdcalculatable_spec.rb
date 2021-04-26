require './bkwdcalculatable'
require './enigma'

RSpec.describe BkwdCalculatable do
  enigma = Enigma.new

  it '#align_to_shift rotates the last 4 chars of cyphertext to be in shift order' do
    enigma = Enigma.new
    cyphertext = "vjqtbeaweqihssi"
    expected = {
                cyphertext_end: ["s", "s", "i", "h"],
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

  it '#min_keys returns lowest key values possible with given date and shift' do
    shifts = {A: 14, B: 86, C: 32, D:8}
    date = "291018"
    expected = ["08", "02", "03", "04"]

    expect(enigma.min_keys(shifts, date)).to eq(expected)
  end

  describe '#bkwd_calculate_key' do
    it 'returns a key based on a shift and date' do
      shifts = {A: 14, B: 86%27, C: 32%27, D:8}
      date = "291018"
      cyphertext = "vjqtbeaweqihssi"
      expected = "08304"

      expect(enigma.bkwd_calculate_key(cyphertext, date)).to eq(expected)
    end

    it 'returns a key without a date entered' do
      cyphertext = "qqubqeyigfxmpjzh"
      date = enigma.date_check(Date.today)
      expected_1 = "90357"
      expected_2 = "63084"

      expect(enigma.bkwd_calculate_key(cyphertext, date)).to eq(expected_1).or eq(expected_2)
    end
  end

end
