module Shiftable
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

  def fwd_shift(character, shift_value)
    if @encoder.include?(character.downcase)
      starting_index = @encoder.index(character.downcase)
      total_shift = starting_index + shift_value
      @encoder.rotate(total_shift)[0]
    else
      character
    end
  end

  def bkwd_shift(character, shift_value)
    if @encoder.include?(character.downcase)
      starting_index = @encoder.index(character.downcase)
      total_shift = starting_index - shift_value
      @encoder.rotate(total_shift)[0]
    else
      character
    end
  end

  def bkwd_calculate_shifts(cyphertext)
    cyphertext_end = cyphertext[-4..-1].split("")
    known_end_chars = " end".split("")
    known_end_chars.rotate!(4 - cyphertext.length % 4)
    cyphertext_end.rotate!(4 - cyphertext.length % 4)
    shifts = {}
    cyphertext_end.each_with_index do |character, index|
      shift = @encoder.index(character) - @encoder.index(known_end_chars[index])
      if shift > 0
        shifts[(65 + index).chr.to_sym] = shift
      else
        shift += @encoder.length
        shifts[(65 + index).chr.to_sym] = shift
      end
    end
    shifts
  end

end
