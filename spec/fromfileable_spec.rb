require './lib/fromfileable'

describe FromFileable do

  it '#read_starting_text can read a file, return the text, and close the file' do
    file_name = 'testing.txt'

    expect(FromFileable.read_starting_text(file_name).class).to eq(String)
    expect(FromFileable.read_starting_text(file_name)).to eq("test Test test")
    # expect(.closed?).to eq(true) #HOW TO TEST that it is closed without an isntance variable? should be class?
  end

  it '#write_ending_text writes new text to a file' do
    file_name = 'testing_end.txt'
    new_text = "test Test test"
    FromFileable.write_ending_text(file_name, new_text)

    expect(File.open(file_name, "r").read.class).to eq(String)
    expect(File.open(file_name, "r").read).to eq(new_text)
  end

  xit '#encrypt_from_file reads file, writes encryption to new file, returns encryption' do
    start_file = 'testing.txt'
    end_file = 'testing_end.txt'
    message = "test Test test"
    expected = {encryption: "mxghtltgmshtll", key: "08304", date: "240421"}

    enigma = double("enigma")
    allow(enigma).to receive(:encrypt).with(message) do
      expected
    end

    expect(FromFileable.encrypt_from_file(start_file, end_file)).to eq(expected)
    expect(File.open(start_file, "r").read.chomp).to eq("test Test test")
    expect(File.open(end_file, "r").read).to eq(expected[:encryption])
  end

  xit '#decrypt_from_file reads file, writes decryption to new file, returns decryption' do
    start_file = 'testing.txt'
    end_file = 'testing_end.txt'
    key = "82648"
    date = "240818"

    expected = {:decryption=>"Aliya Merali", :key=>"82648", :date=>"240818"}
    #HOW TO STUB this so decryption return is predictable?

    expect(FromFileable.decrypt_from_file(start_file, end_file, key, date)).to eq(expected)
    expect(File.open(start_file, "r").read.chomp).to eq("test Test test")
    expect(File.open(end_file, "r").read).to eq(expected[:encryption])
  end
end
