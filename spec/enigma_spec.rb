require './lib/enigma'

RSpec.describe Enigma do

  describe '#initialize' do
    enigma = Enigma.new

    it 'exists' do
      expect(enigma).to be_instance_of(Enigma)
    end
  end

  describe '#calculate_shift and helper #get_offset' do
    enigma = Enigma.new

    it '#get_offset takes in a date string and returns an offset' do
      date = "220421"
      expect(enigma.get_offset(date)).to eq("7241")
    end

    it '#calculate_shift akes in key and date strings to return shift hash' do
      key = "90357"
      date = "220421"
      expected = {A: 97, B: 5, C: 39, D: 58}

      expect(enigma.calculate_shift(key, date)).to eq(expected)
    end
  end

  describe '#fwd_shift method' do

    it 'shifts a string value by a given amount through a encoder array' do
      shift_value = 97

      expect(fwd_shift("a", shift)).to eq("q")
    end
  end
end
