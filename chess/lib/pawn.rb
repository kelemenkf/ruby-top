# frozen_string_literal: true

require_relative './pieces'

class Pawn < Pieces
  attr_accessor :moved
  def initialize(position, symbol, color)
    super
    @moved = false
  end 

  def valid(old_pos, new_pos)
    valid = false
    r = old_pos[0]
    puts r
    c = old_pos[1]
    puts c
    if @moved && @color == 'b'
      rank_moves = [1]
      file_moves = [0]

      for i in (0..rank_moves.length-1)
        rr = r + rank_moves[i]
        cc = c + file_moves[i]
        if (0..7).include?(rr) && (0..7).include?(cc) && rr = new_pos[0] && cc == new_pos[1]
          valid = true
        end
      end
    elsif !@moved && @color == 'b'
      rank_moves = [1,2]
      file_moves = [0,0]

      for i in (0..rank_moves.length-1)
        rr = r + rank_moves[i]
        cc = c + file_moves[i]
        if (0..7).include?(rr) && (0..7).include?(cc) && rr == new_pos[0] && cc == new_pos[1]
          valid = true
        end
      end
    end

    if @moved && @color == 'w'
      rank_moves = [-1]
      file_moves = [0]

      for i in (0..rank_moves.length-1)
        rr = r + rank_moves[i]
        cc = c + file_moves[i]
        if (0..7).include?(rr) && (0..7).include?(cc) && rr = new_pos[0] && cc == new_pos[1]
          valid = true
        end
      end
    elsif !@moved && @color == 'w'
      rank_moves = [-1,-2]
      file_moves = [0,0]

      for i in (0..rank_moves.length-1)
        rr = r + rank_moves[i]
        cc = c + file_moves[i]
        if (0..7).include?(rr) && (0..7).include?(cc) && rr == new_pos[0] && cc == new_pos[1]
          valid = true
        end
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
    if @color == 'b'
      for i in (0..(rr-r).abs-1)
        r += 1
        path << [r,c]
      end
    else 
      for i in (0..(rr-r).abs-1)
        r -= 1
        path << [r,c]
      end
    end
    p path
  end

  #TODO taking and en passant
end
