require 'Date'
require './shiftable'

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
    else
      "Date not in accepted format"
    end
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

end
