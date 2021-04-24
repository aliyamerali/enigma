require 'pry'

module FromFileable

  def self.read_starting_text(file)
    start_file = File.open(file, "r")
    message = start_file.read.chomp
    start_file.close
    message
  end


end
