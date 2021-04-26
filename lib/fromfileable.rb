require './lib/enigma'

module FromFileable

  def self.read_starting_text(file)
    start_file = File.open(file, "r")
    message = start_file.read.chomp
    start_file.close
    message
  end

  def self.write_ending_text(file, new_text)
    end_file = File.open(file, "w")
    end_file.write(new_text)
    end_file.close
  end

  def self.encrypt_from_file(start_file, end_file)
    message = read_starting_text(start_file)
    enigma = Enigma.new
    encrypted_message = enigma.encrypt(message)
    write_ending_text(end_file, encrypted_message[:encryption])
    encrypted_message
  end

  def self.decrypt_from_file(start_file, end_file, key, date)
    encrypted_message = read_starting_text(start_file)
    enigma = Enigma.new
    decrypted_message = enigma.decrypt(encrypted_message, key, date)
    write_ending_text(end_file, decrypted_message[:decryption])
    decrypted_message
  end

  def self.crack_from_file(start_file, end_file, date)
    encrypted_message = read_starting_text(start_file)
    enigma = Enigma.new
    cracked_message = enigma.crack(encrypted_message, date)
    write_ending_text(end_file, cracked_message[:decryption])
    cracked_message
  end
end
