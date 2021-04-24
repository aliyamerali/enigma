require 'Date'
require './shiftable'

class Enigma
  include Shiftable

  def initialize
    @encoder = ("a".."z").to_a << " "
  end

  # def get_offset(date)
  #   squared = date.to_i**2
  #   squared.to_s[-4..-1]
  # end

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
    starting_index = @encoder.index(character.downcase)
    total_shift = starting_index + shift_value
    @encoder.rotate(total_shift)[0]
  end

  def bkwd_shift(character, shift_value)
    starting_index = @encoder.index(character.downcase)
    total_shift = starting_index - shift_value
    @encoder.rotate(total_shift)[0]
  end

  def generate_key
    5.times.map{rand(10)}.join
  end

  def encrypt(message, key=generate_key, date=Date.today) #HOW can we accomodate default value for 3nd not third input?
    date = date_check(date)  #WOULD like this to live in get_offset, but need to ID how to return date in right format for encrypt
    shifts = calculate_shifts(key, date)
    encrypted_message = []
    message.each_char.with_index do |key_element, index|
      shift = shifts[(65 + index%4).chr.to_sym]
      encrypted_message << fwd_shift(key_element, shift)
    end
    {encryption: encrypted_message.join, key: key, date: date}
  end

  def decrypt(message, key, date=Date.today)
    date = date_check(date)
    shifts = calculate_shifts(key, date)
    decrypted_message = []
    message.each_char.with_index do |key_element, index|
      shift = shifts[(65 + index%4).chr.to_sym]
      decrypted_message << bkwd_shift(key_element, shift)
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
