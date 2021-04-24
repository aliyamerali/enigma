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


end
