require './lib/enigma'
require './lib/fromfileable'

start_file = ARGV[0]
end_file = ARGV[1]

message = FromFileable.read_starting_text(start_file)
enigma = Enigma.new
encrypted_message = enigma.encrypt(message)

FromFileable.write_ending_text(end_file, encrypted_message[:encryption])

puts "Created '#{end_file}' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
