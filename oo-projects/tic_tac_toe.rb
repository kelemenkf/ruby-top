# left to do winner
# when do you win: all the rows are the same, all the columns are the same, all the diagonals are the same

class Board
  def initialize
    @board = Array.new(3) { Array.new(3, 0) }
    @start = true
    @wrong_turn = false
    @game_over = false
  end

  attr_accessor :board, :start, :wrong_turn, :game_over

  def display
    puts "#{@board[0]}\n#{board[1]}\n#{board[2]}\n"
  end

  def square_move(r, c)
    if @board[r - 1][c - 1] == 0
      @board[r - 1][c - 1] = 'X'
      @start = false
    else
      @wrong_turn = true
      puts 'Already occupied!'
    end
  end

  def circle_move(r, c)
    if @board[r - 1][c - 1] == 0
      @board[r - 1][c - 1] = 'O'
      @start = true
    else
      @wrong_turn = true
      puts 'Already occupied!'
    end
  end

  def check_winner
    winning_cases = [
      [0, 1, 2],
      [6, 7, 8],
      [3, 4, 5],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
    for o in winning_cases
      if @board.flatten[o[0]] == @board.flatten[o[1]] && @board.flatten[o[1]] == @board.flatten[o[2]] && board.flatten[o[0]] != 0
        puts "Game over. Winner is #{board.flatten[o[0]]}"
        @game_over = true
      end
    end
  end
end

game = Board.new
game.display
round = 0

while round < 9
  r = gets.to_i
  c = gets.to_i
  if r >= 1 && r <= 3 && c >= 1 && c <= 3
    if game.start == true
      game.square_move(r, c)
      if game.wrong_turn == true
        game.display
        round -= 1
        game.wrong_turn = false
      end
    else
      game.circle_move(r, c)
      if game.wrong_turn == true
        game.display
        round -= 1
        game.wrong_turn = false
      end
    end
    game.display
    game.check_winner
    break if game.game_over

    round += 1
    p "This is round #{round}"
  else
    puts 'Incorrect number'
  end
end
