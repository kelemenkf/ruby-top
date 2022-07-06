# frozen_string_literal: true

require_relative './pieces'

class Knight < Pieces
  def initialize(position, symbol, color)
    super
  end

  def valid(old_pos, new_pos)
    valid = false
    r = old_pos[0]
    c = old_pos[1]
    rank_moves = [-2, -1, 1, 2, 2, 1, -1, -2]
    file_moves = [1, 2, 2, 1, -1, -2, -2, -1]

    for i in (0..7)
        rr = r + rank_moves[i]
        cc = c + file_moves[i]
        if (0..7).include?(rr) && (0..7).include?(cc) && rr == new_pos[0] && cc == new_pos[1]
            valid = true
        end
    end 
    return valid
  end
end


