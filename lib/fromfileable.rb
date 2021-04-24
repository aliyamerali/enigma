require 'pry'

module FromFileable

  def self.get_starting_text(file)
    starting_file = File.open(file, "r").read.chomp
  end

end
