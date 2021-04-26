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
    #SHIFTS TO KEY:
      # subtract offset
      # How to check first shift?
      # check tht first char of second shift matches second char of first
      # if not, add 27 until true
      # repeat for 3rd and 4th shift
    # key = #HELPER TO CALCULATE KEY
    # decrypt(cyphertext, key, date)
  end

  # require 'pry'; binding.pry
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
    # require 'pry'; binding.pry
    keys.each_with_index.map do |key, index|
      if index < (keys.length - 1)
        if key[1] != keys[index+1][0]
          if key.to_i > 72 || keys[index+1].to_i > 72
            keys[index] = (key.to_i + 27).to_s if keys[index+1].to_i > 72
            keys[index+1] = (keys[index+1].to_i + 27).to_s if key.to_i > 72
          elsif index != 0
            if key[0] == keys[index-1][1] && keys[index+1][1] != keys[index+2][0]
              keys[index+1] = (keys[index+1].to_i + 27).to_s
            elsif key[0] != keys[index-1][1] && keys[index+1][1] == keys[index+2][0]
              keys[index] = (key.to_i + 27).to_s
            elsif key[0] != keys[index-1][1] && keys[index+1][1] != keys[index+2][0]
              keys[index+1] = (keys[index+1].to_i + 27).to_s
            end
          else
            keys[index+1] = (keys[index+1].to_i + 27).to_s
          end
        end
      end
    end
    keys = keys[0] + keys[2] + keys[3][1]
  end
  
end
