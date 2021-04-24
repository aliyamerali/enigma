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

end
