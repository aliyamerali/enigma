require './shiftable'
require './enigma'

RSpec.describe Shiftable do
  enigma = Enigma.new

  it '#get_offset takes in a date string and returns an offset' do
    date = "220421"

    expect(enigma.get_offset(date)).to eq("7241")
  end

  it '#calculate_shifts takes in key and date strings to return shift hash' do
    key = "90357"
    date = "220421"
    expected = {A: 97, B: 5, C: 39, D: 58}

    expect(enigma.calculate_shifts(key, date)).to eq(expected)
  end

  describe '#fwd_shift method' do
    enigma = Enigma.new

    it 'shifts a string value by a given amount through a encoder array' do
      shift_value = 97

      expect(enigma.fwd_shift("a", shift_value)).to eq("q")
      expect(enigma.fwd_shift("R", shift_value)).to eq("g")
    end

    it 'takes any integer shift_value' do
      shift_value = 5

      expect(enigma.fwd_shift("l", shift_value)).to eq("q")
      expect(enigma.fwd_shift(" ", shift_value)).to eq("e")
    end

    it 'does not shift characters not in the @encoder set' do
      shift_value = 5

      expect(enigma.fwd_shift(".", shift_value)).to eq(".")
      expect(enigma.fwd_shift("!", shift_value)).to eq("!")
      expect(enigma.fwd_shift("@", shift_value)).to eq("@")
      expect(enigma.fwd_shift(" ", shift_value)).to eq("e")
    end
  end

  describe '#bkwd_shift method' do
    enigma = Enigma.new

    it 'shifts a string value by a given amount backwards through a encoder array' do
      shift_value = 97

      expect(enigma.bkwd_shift("q", shift_value)).to eq("a")
      expect(enigma.bkwd_shift("G", shift_value)).to eq("r")
    end

    it 'takes any integer shift_value' do
      shift_value = 5

      expect(enigma.bkwd_shift("Q", shift_value)).to eq("l")
      expect(enigma.bkwd_shift("e", shift_value)).to eq(" ")
    end

    it 'does not shift characters not in the @encoder set' do
      shift_value = 5

      expect(enigma.bkwd_shift(".", shift_value)).to eq(".")
      expect(enigma.bkwd_shift("!", shift_value)).to eq("!")
      expect(enigma.bkwd_shift("@", shift_value)).to eq("@")
      expect(enigma.bkwd_shift("Q", shift_value)).to eq("l")
    end
  end

  describe '#align_to_shift' do
    enigma = Enigma.new
    cyphertext = "vjqtbeaweqihssi"
    expected = {
                cyphertext_final_four: ["s", "s", "i", "h"],
                known_end: ["e", "n", "d", " "]
                }

    it 'rotates the last 4 chars of cyphertext to be in shift order' do
      expect(enigma.align_to_shift(cyphertext)).to eq(expected)
    end
  end

  describe '#bkwd_calculate_shifts' do
    enigma = Enigma.new
    cyphertext = "vjqtbeaweqihssi"
    expected = {A: 14, B: 86%27, C: 32%27, D:8}

    it 'returns the shifts based on cyphertext and a date' do
      expect(enigma.bkwd_calculate_shifts(cyphertext)).to eq(expected)
    end
  end

end
