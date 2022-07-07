# frozen_string_literal: true

require_relative './board'
require_relative './pieces'
require_relative './knight'
require_relative './bishop'
require_relative './rook'
require_relative './king'
require_relative './queen'

game_over = false
board = Board.new
board.display_starting_position
until game_over
    board.to_s(board.display_board)
    board.to_s(board.pos_board)
    old_pos = gets.chomp
    new_pos = gets.chomp 
    board.move(old_pos, new_pos)
end