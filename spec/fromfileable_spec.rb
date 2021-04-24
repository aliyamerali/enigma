require './lib/fromfileable'

describe FromFileable do

  it '#get_starting_text can read a file passed in and return the text' do
    file_name = 'testing.txt'

    expect(FromFileable.get_starting_text(file_name).class).to eq(String)
    expect(FromFileable.get_starting_text(file_name)).to eq("test, Test, test.")
  end

end
