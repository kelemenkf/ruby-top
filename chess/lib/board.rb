# frozen_string_literal: true

# there needs to be a board, pieces, and rules on how to move those pieces
# also test for check and for mate
# board will be serialized

class Board
  attr_accessor :display_board, :code_board
  def initialize
    @display_board = Array.new(8) { Array.new(8) }
    @code_board = code_board()
  end

  def code_board
    board = Array.new(8) {Array.new(8)}
    pos = []
    for i in (1..8)
      for j in ('a'..'h')
        pos << j+"#{i}"
      end
    end

    for i in (0..7)
        board[i] = pos.filter { |x| x.include?((i-8).abs().to_s) }
    end
    board
  end

  def encode_position(pos)
    return code_board[pos[0]][pos[1]]
  end

  def decode_position(pos)
    result = []
    for i in (0..7)
      for j in (0..7)
        if pos == code_board[i][j]
          puts pos
          puts code_board[i][j]
          result.append(i,j)
        end
      end
    end
    result
  end

  def to_s(board)
    (0..8).each do |i|
      puts "#{board[i]}\n"
    end
  end

  def place_pieces(piece)
    pos = decode_position(piece.position)
    r = pos[0]
    c = pos[1]
    display_board[r][c] = piece.symbol 
  end
end

