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
    return valid
  end 
  
  def path(old_pos, new_pos)
    r = old_pos[0]
    c = old_pos[1]
    rr = new_pos[0]
    cc = new_pos[1]
    rank_moves = [1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    file_moves = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7]
    path = []
    # path[0] = old_pos
    # puts old_pos
    # puts new_pos
    # for i in (0..rank_moves.length-1)
    #   rr = r + rank_moves[i]
    #   cc = c + file_moves[i]
    #   if (0..7).include?(rr) && (0..7).include?(cc)
    #     path << [rr,cc]
    #   end
    # end
    #for the rook specifically, we can iterate over the board
    #if the first position is equal in the old and new, then we take those where it is the same in the board
    #and the second is between the variable position of the rook. But what about the bishop. We can again take the valid possible moves. 
    #iterate over the whole board, figure out which one is the way. So for example, if first is in the old and the second is smaller, them 
    #we take the absolute value of either of the differences, and decrease the larger one and increase the smaller one. 
    #what if we have the path. we return it, and see if on the code_board at those positions, the value is nil, 
    board = Array.new(8) { Array.new(8) } 
    for i in (0..(r-c).abs-1)
      if rr >= r && cc >= c
        path << [r+1, c+1]
      # elsif rr <= r && cc >= c
      # elsif rr >= r && cc <= c
      # elsif rr <= r && cc <= c
      end
    end
    p path
    return path
  end
end 

