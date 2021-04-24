require './shiftable'
require './enigma'

RSpec.describe Shiftable do
  enigma = Enigma.new

  it '#get_offset takes in a date string and returns an offset' do
    date = "220421"
    
    expect(enigma.get_offset(date)).to eq("7241")
  end


end
