module BkwdCalculatable

  def bkwd_calculate_key(ciphertext, date)
    min_keys = min_keys(ciphertext, date)
    possible_keys = all_possible_keys(min_keys)
    final_key = possible_keys.find do |key|
      key[0][1] == key[1][0] && key[1][1] == key[2][0] && key[2][1] == key[3][0]
    end
    if final_key.nil?
      "No possible key for this ciphertext with today's date. Please enter another date."
    else
      final_key[0] + final_key[2] + final_key[3][1]
    end
  end

  def bkwd_calculate_shifts(ciphertext)
    ciphertext_end = align_to_shift(ciphertext)[:ciphertext_end]
    known_end = align_to_shift(ciphertext)[:known_end]
    shifts = {}
    ciphertext_end.each_with_index do |character, index|
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

  def align_to_shift(ciphertext)
    ciphertext_end = ciphertext[-4..-1].split("")
    known_end = " end".split("")
    end_chars = {ciphertext_end: ciphertext_end, known_end: known_end}
    end_chars.each do |key, end_char|
      end_chars[key] = end_char.rotate!(4 - ciphertext.length % 4)
    end
  end

  def format_key(key)
    if key.to_s.length == 2
      key.to_s
    else
      "0" + key.to_s
    end
  end

  def min_keys(ciphertext, date)
    shifts = bkwd_calculate_shifts(ciphertext)
    offset = get_offset(date)
    keys = []
    shifts.values.each_with_index do |shift, index|
      key = shift - offset[index].to_i
      keys << format_key(key)
    end
    keys
  end

  def congruent_key_vals(min_keys)
    interval = @encoder.length
    max = 99 - interval
    congruencies = {}
    interval = @encoder.length
    max = 99 - interval
    min_keys.each_with_index do |key, index|
      congruencies[index] = [key]
      key_value = key.to_i
      while key_value < max
        key_value += interval
        congruencies[index] << format_key(key_value)
      end
    end
    congruencies
  end

  def all_possible_keys(min_keys)
    congruencies = congruent_key_vals(min_keys)
    possibilities = []
    values = congruencies.values
    values[0].each do |first_key|
      values[1].each do |second_key|
        values[2].each do |third_key|
          values[3].each do |fourth_key|
            possibilities << [first_key, second_key, third_key, fourth_key]
          end
        end
      end
    end
    possibilities
  end
end
