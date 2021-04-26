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


end
