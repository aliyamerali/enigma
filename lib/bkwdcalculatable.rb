module BkwdCalculatable

  def align_to_shift(cyphertext)
    cyphertext_end = cyphertext[-4..-1].split("")
    known_end = " end".split("")
    end_chars = {cyphertext_end: cyphertext_end, known_end: known_end}
    end_chars.each do |key, end_char|
      end_chars[key] = end_char.rotate!(4 - cyphertext.length % 4)
    end
  end

  def bkwd_calculate_shifts(cyphertext)
    cyphertext_end = align_to_shift(cyphertext)[:cyphertext_end]
    known_end = align_to_shift(cyphertext)[:known_end]
    shifts = {}
    cyphertext_end.each_with_index do |character, index|
      shift = @encoder.index(character) - @encoder.index(known_end[index])
      if shift > 0
        shifts[(65 + index).chr.to_sym] = shift
      else
        shift += @encoder.length
        shifts[(65 + index).chr.to_sym] = shift
      end
    end
    shifts
  end

  def format_key(key)
    if key.to_s.length == 2
      key.to_s
    else
      "0" + key.to_s
    end
  end

  def min_keys(cyphertext, date)
    shifts = bkwd_calculate_shifts(cyphertext)
    offset = get_offset(date)
    keys = []
    shifts.values.each_with_index do |shift, index|
      key = shift - offset[index].to_i
      keys << format_key(key)
    end
    keys
  end

  def congruent_key_vals(min_keys)
    congruencies = {}
    interval = @encoder.length
    max = 99 - interval
    min_keys.each_with_index do |key, index|
      congruencies[index] = [key]
      key_value = key.to_i
      while key_value < max
        key_value += interval
        congruencies[index] << key_value.to_s
      end
    end
    congruencies
  end

  def bkwd_calculate_key(cyphertext, date)
    min_keys = min_keys(cyphertext, date)

    congruencies = congruent_key_vals(min_keys)
    possibilities = []
    values = congruencies.values
    values[0].each do |a_elem|
      values[1].each do |b_elem|
        values[2].each do |c_elem|
          values[3].each do |d_elem|
            possibilities << [a_elem, b_elem, c_elem, d_elem]
          end
        end
      end
    end

    final_key = possibilities.find do |min_keys|
      min_keys[0][1] == min_keys[1][0] && min_keys[1][1] == min_keys[2][0] && min_keys[2][1] == min_keys[3][0]
    end

    if final_key.nil?
      "No possible key for this cyphertext with today's date. Please enter another date."
    else
      final_key[0] + final_key[2] + final_key[3][1]
    end
  end
end
