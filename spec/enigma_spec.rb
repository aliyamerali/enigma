require './lib/enigma'
require 'date'

RSpec.describe Enigma do

  describe '#initialize' do
    enigma = Enigma.new

    it 'exists' do
      expect(enigma).to be_instance_of(Enigma)
    end
  end

  describe '#calculate_shifts and helper #get_offset and #date_check' do
    enigma = Enigma.new

    it '#get_offset takes in a date string and returns an offset' do
      date = "220421"
      expect(enigma.get_offset(date)).to eq("7241")
    end

    describe '#date_check' do
      enigma = Enigma.new

      it 'checks that a date is in the required string format, modifies it if not' do
        expect(enigma.date_check("230421")).to eq("230421")
        expect(enigma.date_check(Date.new(1995,8,4))).to eq("040895")
      end
    end

    it '#calculate_shifts akes in key and date strings to return shift hash' do
      key = "90357"
      date = "220421"
      expected = {A: 97, B: 5, C: 39, D: 58}

      expect(enigma.calculate_shifts(key, date)).to eq(expected)
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

    it 'returns the encoded string passed in' do
      key = "90357"
      date = "220421"
      message = "Aliya Merali"
      expected = {encryption: "qqubqeyigfxm", key: key, date: date}

      expect(enigma.encrypt(message, key, date)).to eq(expected)
    end

    it 'uses default date of today if no date passed in' do
      allow(Date).to receive(:today) do
        Date.new(1995,8,4)
      end

      key = "02715"
      message = "Hello World"
      expected = {encryption: "keder ohulw", key: key, date: "040895"}

      expect(enigma.encrypt(message, key)).to eq(expected)
    end
  end

end
