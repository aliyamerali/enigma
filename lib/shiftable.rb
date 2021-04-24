module Shiftable
#TO CONTAIN ALL SHIFTING RELATED BEHAVIOR
  def get_offset(date)
    squared = date.to_i**2
    squared.to_s[-4..-1]
  end

end
