# frozen_string_literal: true

require_relative './pieces'

class Knight < Pieces
  def initialize(position, symbol, color)
    super
  end

  def valid(pos)
    valid = false
    r = pos[0]
    c = pos[1]
    rank_moves = [-2, -1, 1, 2, 2, 1, -1, -2]
    file_moves = [1, 2, 2, 1, -1, -2, -2, -1]

    for i in (0..7)
        r = r + rank_moves[i]
        c = c + file_moves[i]
        if (0..7).include?(r) && (0..7).include?(c)
            valid = true
        end
    end 
    return valid
  end
end

