require './lib/enigma'
require './lib/fromfileable'

start_file = ARGV[0]
end_file = ARGV[1]
date = ARGV[2]

cracked_message = FromFileable.crack_from_file(start_file, end_file, date)

puts "Created '#{end_file}' with the cracked key #{cracked_message[:key]} and date #{cracked_message[:date]}"
