# frozen_string_literal: true

require_relative './pieces'

class Rook < Pieces
  def initialize(position, symbol, color)
    super
  end

  def valid(old_pos, new_pos)
    valid = false
    r = old_pos[0]
    c = old_pos[1]
    rank_moves = [1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    file_moves = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7]

    for i in (0..rank_moves.length-1)
      rr = r + rank_moves[i]
      cc = c + file_moves[i]
      if (0..7).include?(rr) && (0..7).include?(cc) && rr == new_pos[0] && cc == new_pos[1]
        valid = true
      end
    end
    return valid
  end 
  
  def path(old_pos, new_pos)
    r = old_pos[0]
    c = old_pos[1]
    rr = new_pos[0]
    cc = new_pos[1]
    path = []
    if rr != r
      for i in (0..(r-rr).abs)
        if rr > r && cc = c
          r += 1
          path << [r, c]
        elsif rr < r && cc = c
          r -= 1
          path << [r, c]
        end
      end
    elsif cc != c
      for i in (0..(c-cc).abs)
        if rr = r && cc > c
          c += 1
          path << [r, c]
        elsif rr = r && cc < c
          c -= 1
          path << [r, c]
        end
      end
    end
    return path
  end
end 

