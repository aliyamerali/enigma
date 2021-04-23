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
  end

  describe '#encrypt' do
    enigma = Enigma.new
    key = "90357"
    date = "220421"
    message = "Aliya Merali"

    expected = {
                encryption: "qqubqeyigfxm",
                key: key,
                date: date
               }

    it 'returns the encoded string passed in' do
      expect(encrypt(message, key, date)).to eq(expected)
    end
  end
end
