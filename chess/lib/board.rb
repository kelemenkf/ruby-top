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
  attr_accessor :display_board, :pos_board, :code_board
  def initialize
    @display_board = display_board_maker
    @pos_board = pos_board_maker
    @code_board = code_board_maker
  end

  def pos_board_maker
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

  def code_board_maker
    board = Array.new(8) { Array.new(8) }
  end

  def encode_position(pos)
    pos_board[pos[0]][pos[1]]
  end

  def decode_position(pos)
    result = []
    (0..7).each do |i|
      (0..7).each do |j|
        next unless pos == pos_board[i][j]

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

  def display_pieces(piece)
    pos = decode_position(piece.position)
    r = pos[0]
    c = pos[1]
    display_board[r][c] = piece.symbol
  end

  def remove_pieces(piece)
    pos = decode_position(piece.position)
    r = pos[0]
    c = pos[1]
    display_board[r][c] = ' '
  end

  def encode_pieces(piece)
    pos = decode_position(piece.position)
    r = pos[0]
    c = pos[1]
    code_board[r][c] = piece
  end

  def decode_pieces(piece)
    pos = decode_position(piece.position)
    r = pos[0]
    c = pos[1]
    code_board[r][c] = nil
  end

  def display_starting_position
    knights = []
    knights << opposite_knight_white = Knight.new('g1', "\u2658", 'w')
    knights << same_knight_white = Knight.new('b1', "\u2658", 'w')
    knights << opposite_knight_black = Knight.new('g8', "\u265e", 'b')
    knights << same_knight_black = Knight.new('b8', "\u265e", 'b')
    knights.each do |i|
      display_pieces(i)
      encode_pieces(i)
    end

    bishops = []
    bishops << opposite_bishop_white = Bishop.new('c1', "\u2657", 'w')
    bishops << same_bishop_white = Bishop.new('f1', "\u2657", 'w')
    bishops << opposite_bishop_black = Bishop.new('c8', "\u265d", 'b')
    bishops << same_bishop_black = Bishop.new('f8', "\u265d", 'b')
    bishops.each do |i|
      display_pieces(i)
      encode_pieces(i)
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
      display_pieces(i)
      encode_pieces(i)
    end

    rooks = []
    rooks << opposite_rook_white = Rook.new('a1', "\u2656", 'w')
    rooks << same_rook_white = Rook.new('h1', "\u2656", 'w')
    rooks << opposite_rook_black = Rook.new('a8', "\u265c", 'b')
    rooks << same_rook_black = Rook.new('h8', "\u265c", 'b')
    for i in rooks 
      display_pieces(i)
      encode_pieces(i)
    end

    queens = []
    queens << white_queen = Queen.new('d1', "\u2655", 'w')
    queens << black_queen = Queen.new('d8', "\u265b", 'b')
    for i in queens
      display_pieces(i)
      encode_pieces(i)
    end

    kings = []
    kings << white_king = King.new('e1', "\u2654", 'w')
    kings << black_king = King.new('e8', "\u265a", 'b')
    for i in kings
      display_pieces(i)
      encode_pieces(i)
    end
  end

  def move(old_pos, new_pos)
    new_pos = decode_position(new_pos)
    piece = piece_at(old_pos)
    old_pos = decode_position(old_pos)
    validity = piece.valid(old_pos, new_pos)
    path = piece.path(old_pos, new_pos)
    path_validity = path_checker(path)
    puts path_validity  
    if validity && path_validity
      remove_pieces(piece)
      decode_pieces(piece)
      piece.position = encode_position(new_pos)
      display_pieces(piece)
      encode_pieces(piece)
    else
      puts "Invalid move"
    end
  end

  def piece_at(pos)
    pos = decode_position(pos)
    return code_board[pos[0]][pos[1]]
  end

  def path_checker(path)
    path_valid = true
    for i in path
      #see if on the code_board at those positions the value is nil
      r = i[0]
      c = i[1]
      if code_board[r][c] != nil
        path_valid = false
      end
    end
    return path_valid
  end

  #TODO alternate between turns for different colors
  def turn_color(piece)
  end
end






