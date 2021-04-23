require './lib/enigma'

start_file_name = ARGV[0]
end_file_name = ARGV[1]

start_file = File.open(start_file_name, "r")
message = start_file.read.chomp
start_file.close

enigma = Enigma.new
encrypted_message = enigma.encrypt(message)

end_file = File.open(end_file_name, "w")
end_file.write(encrypted_message[:encryption])
end_file.close

puts "Created '#{end_file_name}' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
