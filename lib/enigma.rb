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

    keys.each_with_index.map do |key, index|
      # require 'pry'; binding.pry
      if index != keys.length
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

      keys
    end
    # lock_status = {
    #               keys[0] => false,
    #               keys[1] => false,
    #               keys[2] => false,
    #               keys[3] => false
    #               }
    #
    # until keys[0][1] == keys[1][0] && keys[1][1] == keys[2][0] && keys[2][1] == keys[3][0] || !lock_status.values.include?(false)
    #   if keys[0][1] == keys[1][0] && keys[1][1] == keys[2][0] && keys[2][1] != keys[3][0]
    #     if keys[3].to_i + @encoder.length < 100
    #       keys[3] = (keys[3].to_i + @encoder.length).to_s
    #     else
    #       lock_status[keys[3]] == true
    #     end
    #   elsif keys[0][1] == keys[1][0] && keys[1][1] != keys[2][0] && keys[2][1] != keys[3][0]
    #     if keys[2].to_i + @encoder.length < 100
    #       keys[2] = (keys[2].to_i + @encoder.length).to_s
    #     else
    #       lock_status[keys[2]] == true
    #     end
    #   elsif keys[0][1] != keys[1][0] && keys[1][1] != keys[2][0] && keys[2][1] == keys[3][0]
    #     if keys[1].to_i + @encoder.length < 100
    #       keys[1] = (keys[1].to_i + @encoder.length).to_s
    #     else
    #       lock_status[keys[1]] == true
    #     end
    #   elsif keys[0][1] != keys[1][0] && keys[1][1] == keys[2][0] && keys[2][1] == keys[3][0]
    #     if keys[0].to_i + @encoder.length < 100
    #       keys[0] = (keys[0].to_i + @encoder.length).to_s
    #     else
    #       lock_status[keys[0]] == true
    #     end
    #   else
    #     puts "end of the line"
    #     random_index = rand(0..3)
    #     if keys[random_index].to_i + @encoder.length < 100
    #       keys[random_index] = (keys[random_index].to_i + @encoder.length).to_s
    #     else
    #       lock_status[keys[random_index]] == true
    #     end
    #   end
    # end

    # keys = keys[0] + keys[2] + keys[3][1]

  end

end
