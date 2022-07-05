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
    def initialize(position, symbol, color)
        super
    end

    def move(pos)
        rank_moves = [-2,-1,1,2,2,1,-1,-2]
        file_moves = [1,2,2,1,-1,-2,-2,-1]

        #possible moves need to be considered. how to move one piece? 
        #command line so you have to type
    end

    def starting_position
    end
end

knight = Knight.new('b1', "\u2658", 'w')
knight_black = Knight.new('b8', "\u265e", 'b')
board = Board.new
board.to_s(board.code_board)
board.place_pieces(knight)
board.place_pieces(knight_black)
board.to_s(board.display_board)

