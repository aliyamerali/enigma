require 'Date'

class Enigma

  def get_offset(date)
    date = date_check(date)
    squared = date.to_i**2
    squared.to_s[-4..-1]
  end

  def date_check(date)
    if date.class == String
      date
    elsif date.class == Date
      date.strftime("%d%m%y")
    else
      "Date not in accepted format"
    end
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
    encoder = ("a".."z").to_a << " "
    starting_index = encoder.index(character.downcase)
    total_shift = starting_index + shift_value
    encoder.rotate(total_shift)[0]
  end

  def encrypt(message, key, date=Date.today)
    shifts = calculate_shifts(key, date)
    encrypted_message = []
    message.each_char.with_index do |key_element, index|
      shift = shifts[(65 + index%4).chr.to_sym]
      encrypted_message << fwd_shift(key_element, shift)
    end
    {encryption: encrypted_message.join, key: key, date: date}
  end
end
