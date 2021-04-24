require './lib/fromfileable'

describe FromFileable do

  it '#read_starting_text can read a file, return the text, and close the file' do
    file_name = 'testing.txt'

    expect(FromFileable.read_starting_text(file_name).class).to eq(String)
    expect(FromFileable.read_starting_text(file_name)).to eq("test, Test, test.")
    # expect(.closed?).to eq(true) #HOW TO TEST that it is closed without an isntance variable? should be class?
  end

  it '#write_ending_text writes new text to a file' do
    file_name = 'testing.txt'
    new_text = "This is new text being added to the file"
    FromFileable.write_ending_text(file_name, new_text)

    expect(File.open(file, "r").read.class).to eq(String)
    expect(File.open(file, "r").read).to eq(new_text)
  end
  # it '#encrypt_from_file takes in a file and writes encrypted text to new file' do
  #   start_file_name = 'testing.txt'
  #   end_file_name = 'testing_end.txt'
  #
  #   expected_output = {
  #                       encryption: "vjqtbeaweqihssi",
  #                       key: "08304",
  #                       date: "291018"
  #                     }
  #
  #   expect(FromFileable(start_file_name, end_file_name)).to eq(expected_output)
  #   expect()
  # end

end
