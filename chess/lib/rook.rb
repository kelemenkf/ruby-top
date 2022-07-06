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
    #array of old_pos start, new_pos end with the moving rules TODO
    path = []
    start = old_pos
    puts start
    finish = new_pos
    puts finish
    for i in (0..rank_moves.length-1)
      rr = r + rank_moves[i]
      cc = c + file_moves[i]
      path << [rr,cc]
    end
    puts path.to_s
    return valid
  end 
end
