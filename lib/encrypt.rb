require './lib/enigma'
require './lib/fromfileable'

start_file = ARGV[0]
end_file = ARGV[1]

encrypted_message = FromFileable.encrypt_from_file(start_file, end_file)

puts "Created '#{end_file}' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
