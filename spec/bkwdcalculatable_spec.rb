require './bkwdcalculatable'
require './enigma'

RSpec.describe BkwdCalculatable do
  enigma = Enigma.new

  describe '#bkwd_calculate_key' do
    it 'returns a key based on a shift and date' do
      date = "291018"
      ciphertext = "vjqtbeaweqihssi"
      expected = "08304"

      expect(enigma.bkwd_calculate_key(ciphertext, date)).to eq(expected)
    end

    it 'returns a key without a date entered' do
      ciphertext = "qqubqeyigfxmpjzh"
      date = enigma.date_check(Date.today)
      expected_1 = "90357"
      expected_2 = "63084"

      expect(enigma.bkwd_calculate_key(ciphertext, date)).to eq(expected_1).or eq(expected_2)
    end

    it 'returns string warning if no feasible key' do
      ciphertext = "vjqtbeaweqihssi"
      date = "270421"
      expected = "No possible key for this ciphertext with today's date. Please enter another date."

      expect(enigma.bkwd_calculate_key(ciphertext, date)).to eq(expected)
    end
  end

  it '#bkwd_calculate_shifts returns the shifts based on ciphertext and a date' do
    enigma = Enigma.new
    ciphertext = "vjqtbeaweqihssi"
    expected = {A: 14, B: 86%27, C: 32%27, D:8}

    expect(enigma.bkwd_calculate_shifts(ciphertext)).to eq(expected)
  end

  it '#align_to_shift rotates the last 4 chars of ciphertext to be in shift order' do
    enigma = Enigma.new
    ciphertext = "vjqtbeaweqihssi"
    expected = {
      ciphertext_end: ["s", "s", "i", "h"],
      known_end: ["e", "n", "d", " "]
    }

    expect(enigma.align_to_shift(ciphertext)).to eq(expected)
  end

  it '#format_key returns two character string for keys passed as integers' do
    key_int = 9
    key_formatted = "09"

    expect(enigma.format_key(key_int)).to eq(key_formatted)
  end

  it '#min_keys returns lowest key values possible with given date and shift' do
    ciphertext = "vjqtbeaweqihssi"
    date = "291018"
    expected = ["08", "02", "03", "04"]

    expect(enigma.min_keys(ciphertext, date)).to eq(expected)
  end

  it '#congruent_key_vals returns all possible values for each key' do
    min_keys = ["08", "02", "03", "04"]
    expected = {
                0 => ["08", "35", "62", "89"],
                1 => ["02", "29", "56", "83"],
                2 => ["03", "30", "57", "84"],
                3 => ["04", "31", "58", "85"]
                }

    expect(enigma.congruent_key_vals(min_keys)).to eq(expected)
  end

  it '#all_possible_keys returns all possible key sets based on min_keys' do
    min_keys = ["08", "02", "03", "04"]

    expect(enigma.all_possible_keys(min_keys).class).to eq(Array)
    expect(enigma.all_possible_keys(min_keys).length).to eq(256)
  end
end
