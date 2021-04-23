require './lib/enigma'

start_file_name = ARGV[0]
end_file_name = ARGV[1]
key = ARGV[2]
date = ARGV[3]

start_file = File.open(start_file_name, "r")
encrypted_message = start_file.read.chomp
start_file.close

enigma = Enigma.new
decrypted_message = enigma.decrypt(encrypted_message, key, date)

end_file = File.open(end_file_name, "w")
end_file.write(decrypted_message[:decryption])
end_file.close

puts "Created '#{end_file_name}' with the key #{decrypted_message[:key]} and date #{decrypted_message[:date]}"
