module BkwdCalculatable

  def align_to_shift(cyphertext)
    cyphertext_end = cyphertext[-4..-1].split("")
    known_end_chars = " end".split("")
    known_end_chars.rotate!(4 - cyphertext.length % 4)
    cyphertext_end.rotate!(4 - cyphertext.length % 4)
    {cyphertext_final_four: cyphertext_end, known_end: known_end_chars}
  end

  def bkwd_calculate_shifts(cyphertext)
    cyphertext_end = align_to_shift(cyphertext)[:cyphertext_final_four]
    known_end_chars = align_to_shift(cyphertext)[:known_end]
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

  def bkwd_calculate_key(shifts, date)
    offset = get_offset(date)
    keys = []
    shifts.values.each_with_index do |shift, index|
      key = shift - offset[index].to_i
      if key.to_s.length == 2
        keys << key.to_s
      else
        key = "0" + key.to_s
        keys << key
      end
    end
    congruencies = {}
    interval = @encoder.length
    max = 99 - interval
    keys.each_with_index do |key, index|
      congruencies[index] = [key]
      key_value = key.to_i
      while key_value < max
        key_value += interval
        congruencies[index] << key_value.to_s
      end
    end

    values = congruencies.values

    possibilities = []
    values[0].each do |a_elem|
      values[1].each do |b_elem|
        values[2].each do |c_elem|
          values[3].each do |d_elem|
            possibilities << [a_elem, b_elem, c_elem, d_elem]
          end
        end
      end
    end
    # require 'pry'; binding.pry
    final_key = possibilities.find do |keys|
      keys[0][1] == keys[1][0] && keys[1][1] == keys[2][0] && keys[2][1] == keys[3][0]
    end
    # require 'pry'; binding.pry

    if final_key.nil?
      "No possible key for this cyphertext with today's date. Please enter another date."
    else
      final_key[0] + final_key[2] + final_key[3][1]
    end
  end
end
