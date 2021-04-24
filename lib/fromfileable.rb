require 'pry'

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
end
