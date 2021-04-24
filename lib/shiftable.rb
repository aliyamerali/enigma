module Shiftable
#TO CONTAIN ALL SHIFTING RELATED BEHAVIOR
  def get_offset(date)
    squared = date.to_i**2
    squared.to_s[-4..-1]
  end

  def calculate_shifts(key, date)
    offset = get_offset(date)
    shifts = {}
    key.each_char.with_index do |key_element, index|
      if index < key.length - 1
        key_value = key_element + key[index+1]
        shifts[(65 + index).chr.to_sym] = key_value.to_i + offset[index].to_i
      end
    end
    shifts
  end

end
