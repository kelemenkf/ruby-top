# frozen_string_literal: true

require_relative './pieces'

class Bishop < Pieces
  def initialize(position, symbol, color)
    super
  end

  def valid(old_pos, new_pos)
    valid = false
    r = old_pos[0]
    c = old_pos[1]
    rank_moves = [1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7,-1,-2,-3,-4,-5,-6,-7,1,2,3,4,5,6,7]
    file_moves = [-1,-2,-3,-4,-5,-6,-7,1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7,1,2,3,4,5,6,7]

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
    path = []
    r = old_pos[0]
    c = old_pos[1]
    rr = new_pos[0]
    cc = new_pos[1]
    for i in (0..(r-c).abs)
      if rr > r && cc > c
        r += 1
        c += 1
        path << [r, c]
      elsif rr < r && cc > c
        r -= 1
        c += 1
        path << [r, c]
      elsif rr > r && cc < c
        r += 1
        c -= 1
        path << [r, c]
      elsif rr < r && cc < c
        r -= 1
        c -= 1
        path << [r, c]
      end
    end
    p path
  end
end
