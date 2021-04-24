require './lib/enigma'
require './lib/fromfileable'

start_file = ARGV[0]
end_file_name = ARGV[1]
key = ARGV[2]
date = ARGV[3]

encrypted_message = FromFileable.read_starting_text(start_file)

enigma = Enigma.new
decrypted_message = enigma.decrypt(encrypted_message, key, date)

FromFileable.write_ending_text(end_file_name, decrypted_message)

puts "Created '#{end_file_name}' with the key #{decrypted_message[:key]} and date #{decrypted_message[:date]}"
