# frozen_string_literal: true

# there needs to be a board, pieces, and rules on how to move those pieces
# also test for check and for mate
# board will be serialized
require_relative './pawn'
require_relative './knight'
require_relative './bishop'
require_relative './rook'
require_relative './queen'
require_relative './king'

class Board
  attr_accessor :display_board, :code_board
  def initialize
    @display_board = display_board_maker
    @code_board = code_board_maker
  end

  def code_board_maker
    board = Array.new(8) { Array.new(8) }
    pos = []
    (1..8).each do |i|
      ('a'..'h').each do |j|
        pos << j + i.to_s
      end
    end

    (0..7).each do |i|
      board[i] = pos.filter { |x| x.include?((i - 8).abs.to_s) }
    end
    board
  end

  def display_board_maker
    board = Array.new(8, ' ') { Array.new(8, ' ') }
  end

  def encode_position(pos)
    code_board[pos[0]][pos[1]]
  end

  def decode_position(pos)
    result = []
    (0..7).each do |i|
      (0..7).each do |j|
        next unless pos == code_board[i][j]

        result.append(i, j)
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

  def starting_position
    knights = []
    knights << opposite_knight_white = Knight.new('g1', "\u2658", 'w')
    knights << same_knight_white = Knight.new('b1', "\u2658", 'w')
    knights << opposite_knight_black = Knight.new('g8', "\u265e", 'b')
    knights << same_knight_black = Knight.new('b8', "\u265e", 'b')
    knights.each do |i|
      place_pieces(i)
    end

    bishops = []
    bishops << opposite_bishop_white = Bishop.new('c1', "\u2657", 'w')
    bishops << same_bishop_white = Bishop.new('f1', "\u2657", 'w')
    bishops << opposite_bishop_black = Bishop.new('c8', "\u265d", 'b')
    bishops << same_bishop_black = Bishop.new('f8', "\u265d", 'b')
    bishops.each do |i|
      place_pieces(i)
    end

    pawns = []
    pawns << pawn_1_white = Pawn.new('a2', "\u2659", 'w')
    pawns << pawn_2_white = Pawn.new('b2', "\u2659", 'w')
    pawns << pawn_3_white = Pawn.new('c2', "\u2659", 'w')
    pawns << pawn_4_white = Pawn.new('d2', "\u2659", 'w')
    pawns << pawn_5_white = Pawn.new('e2', "\u2659", 'w')
    pawns << pawn_6_white = Pawn.new('f2', "\u2659", 'w')
    pawns << pawn_7_white = Pawn.new('g2', "\u2659", 'w')
    pawns << pawn_8_white = Pawn.new('h2', "\u2659", 'w')
    pawns << pawn_1_black = Pawn.new('a7', "\u265f", 'b')
    pawns << pawn_2_black = Pawn.new('b7', "\u265f", 'b')
    pawns << pawn_3_black = Pawn.new('c7', "\u265f", 'b')
    pawns << pawn_4_black = Pawn.new('d7', "\u265f", 'b')
    pawns << pawn_5_black = Pawn.new('e7', "\u265f", 'b')
    pawns << pawn_6_black = Pawn.new('f7', "\u265f", 'b')
    pawns << pawn_7_black = Pawn.new('g7', "\u265f", 'b')
    pawns << pawn_8_black = Pawn.new('h7', "\u265f", 'b')
    for i in pawns
      place_pieces(i)
    end

    rooks = []
    rooks << opposite_rook_white = Rook.new('a1', "\u2656", 'w')
    rooks << same_rook_white = Rook.new('h1', "\u2656", 'w')
    rooks << opposite_rook_black = Rook.new('a8', "\u265c", 'b')
    rooks << same_rook_black = Rook.new('h8', "\u265c", 'b')
    for i in rooks 
      place_pieces(i)
    end

    queens = []
    queens << white_queen = Queen.new('d1', "\u2655", 'w')
    queens << black_queen = Queen.new('d8', "\u265b", 'b')
    for i in queens
      place_pieces(i)
    end

    kings = []
    kings << white_king = King.new('e1', "\u2654", 'w')
    kings << black_king = King.new('e8', "\u265a", 'b')
    for i in kings
      place_pieces(i)
    end
  end
end

board = Board.new
board.to_s(board.code_board)
board.starting_position
board.to_s(board.display_board)
knight = Knight.new('b1', "\u2658", 'w')
pos = board.decode_position('c3')
res = knight.valid(pos)
if res
  knight.position = 'c3'
  board.place_pieces(knight)
end
