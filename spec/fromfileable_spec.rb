require './lib/fromfileable'

describe FromFileable do

  it '#get_starting_text can read a file passed in and return the text' do
    file_name = message.txt

    expect(get_starting_text(file_name)).to eq("Aliya Merali")
  end

end
