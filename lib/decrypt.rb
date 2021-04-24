require './lib/enigma'
require './lib/fromfileable'

start_file = ARGV[0]
end_file = ARGV[1]
key = ARGV[2]
date = ARGV[3]

decrypted_message = FromFileable.decrypt_from_file(start_file, end_file, key, date)

puts "Created '#{end_file}' with the key #{decrypted_message[:key]} and date #{decrypted_message[:date]}"
