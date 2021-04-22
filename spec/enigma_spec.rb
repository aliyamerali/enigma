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
      key = 90357
      date = "220421"
      expected = {A: 97, B: 5, C: 39, D: 58}

      expect(enigma.calculate_shift).to eq(expected)
    end
  end
end
