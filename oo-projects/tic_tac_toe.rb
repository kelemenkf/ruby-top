# there has to be a board 3x3 grid
# state is what is displayed
# behaviour is circle and square
# players play in turn so some sort of switch
# each player should only have access to either circle or square
# both has to have access to the board, so that should be class variable

class Board
  def initialize
    @board = Array.new(3) { Array.new(3, 0) }
    @start = true
  end

  attr_reader :board, :start

  def display
    puts "#{@board[0]}\n#{board[1]}\n#{board[2]}\n"
  end

  def square_move(r, c)
    if @board[r-1][c-1] == 0
        @board[r-1][c-1] = 'X'
        @start = false
    else
        puts "Already occupied!" 
    end
  end

  def circle_move(r, c)
    if @board[r-1][c-1] == 0
        @board[r-1][c-1] = 'O'
        @start = true
    else
        puts "Already occupied!" 
    end
  end    
end

game = Board.new
game.display
round = 0

while round < 9
    r = gets.to_i
    c = gets.to_i
    if game.start == true
        game.square_move(r, c)
    else 
        game.circle_move(r, c)
    end
    game.display
    round += 1
end