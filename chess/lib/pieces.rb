require_relative './board'


class Pieces
    attr_accessor :position, :symbol, :color
    def initialize(position, symbol, color)
        @position = position 
        @symbol = symbol
        @color = color
    end
end

class Knight < Pieces
    def initialize
        super('b1', 'K', 'w')
    end

    def move(pos)
        rank_moves = [-2,-1,1,2,2,1,-1,-2]
        file_moves = [1,2,2,1,-1,-2,-2,-1]

        #possible moves need to be considered. how to move one piece? 
        #command line so you have to type
    end
end

knight = Knight.new
board = Board.new
board.to_s(board.code_board)
board.place_pieces(knight)
board.to_s(board.display_board)

