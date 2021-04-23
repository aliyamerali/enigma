class Enigma


  def get_offset(date)
    squared = date.to_i**2
    squared.to_s[-4..-1]
  end

  def calculate_shift(key, date)
    offset = get_offset(date)
    shift = {}
    key.each_char.with_index do |key_element, index|
      if index < key.length - 1
        key_value = key_element + key[index+1]
        shift[(65 + index).chr.to_sym] = key_value.to_i + offset[index].to_i
      end
    end
    shift
  end


end
