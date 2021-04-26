require 'Date'
require './lib/shiftable'

class Enigma
  include Shiftable

  def initialize
    @encoder = ("a".."z").to_a << " "
  end

  def date_check(date)
    if date.class == String
      date
    elsif date.class == Date
      date.strftime("%d%m%y")
    end
  end

  def generate_random_key
    5.times.map{rand(10)}.join
  end

  def encrypt(message, key=generate_random_key, date=Date.today)
    date = date_check(date)
    shifts = calculate_shifts(key, date)
    encrypted_message = []
    message.each_char.with_index do |message_char, index|
      shift = shifts[(65 + index%4).chr.to_sym]
      encrypted_message << fwd_shift(message_char, shift)
    end
    {encryption: encrypted_message.join, key: key, date: date}
  end

  def decrypt(message, key, date=Date.today)
    date = date_check(date)
    shifts = calculate_shifts(key, date)
    decrypted_message = []
    message.each_char.with_index do |message_char, index|
      shift = shifts[(65 + index%4).chr.to_sym]
      decrypted_message << bkwd_shift(message_char, shift)
    end
    {decryption: decrypted_message.join, key: key, date: date}
  end

  def crack(cyphertext, date=Date.today)
    date = date_check(date)
    shifts = bkwd_calculate_shifts(cyphertext)

    # decrypt(cyphertext, key, date)
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
    keys = possibilities.find do |keys|
      keys[0][1] == keys[1][0] && keys[1][1] == keys[2][0] && keys[2][1] == keys[3][0]
    end
    # require 'pry'; binding.pry


    keys = keys[0] + keys[2] + keys[3][1]
  end

end
