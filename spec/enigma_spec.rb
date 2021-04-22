require './lib/enigma'

RSpec.describe Enigma do

  describe '#initialize' do
    enigma = Enigma.new

    it 'exists' do
      expect(enigma).to be_instance_of(Enigma)
    end
  end

end
