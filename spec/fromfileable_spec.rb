require './lib/fromfileable'

describe FromFileable do

  it '#read_starting_text can read a file, return the text, and close the file' do
    file_name = 'testing_start.txt'

    expect(FromFileable.read_starting_text(file_name).class).to eq(String)
    expect(FromFileable.read_starting_text(file_name)).to eq("This tests the starting file.")
  end

  it '#write_ending_text writes new text to a file' do
    file_name = 'testing_end.txt'
    new_text = "This tests the ending file."
    FromFileable.write_ending_text(file_name, new_text)

    expect(File.open(file_name, "r").read.class).to eq(String)
    expect(File.open(file_name, "r").read).to eq(new_text)
  end

  it '#encrypt_from_file reads file, writes encryption to new file, returns encryption' do
    start_file = 'testing_start.txt'
    end_file = 'testing_end.txt'
    expected = {encryption: "lunssfjsleet reslnwta l yvqe.", key: "39280", date: "240421"}

    enigma = double("enigma")
    allow(Enigma).to receive(:new) do
      enigma
    end
    allow(enigma).to receive(:encrypt) do
      expected
    end

    expect(FromFileable.encrypt_from_file(start_file, end_file)).to eq(expected)
    expect(File.open(start_file, "r").read.chomp).to eq("This tests the starting file.")
    expect(File.open(end_file, "r").read).to eq(expected[:encryption])
  end

  it '#decrypt_from_file reads file, writes decryption to new file, returns decryption' do
    start_file = 'testing_start.txt'
    end_file = 'testing_end.txt'
    key = "82648"
    date = "240818"
    expected = {decryption: "Decrypted File Stub.", key: "82648", date: "240818"}

    enigma = double("enigma")
    allow(Enigma).to receive(:new) do
      enigma
    end
    allow(enigma).to receive(:decrypt) do
      expected
    end

    expect(FromFileable.decrypt_from_file(start_file, end_file, key, date)).to eq(expected)
    expect(File.open(start_file, "r").read.chomp).to eq("This tests the starting file.")
    expect(File.open(end_file, "r").read).to eq(expected[:decryption])
  end
end
