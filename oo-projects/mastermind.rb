#pegs have two colors depenging on if its both a color and position hit or just color
#color has to be choosen after which it is placed in the grid.
#placement starts at [0][0], and goes progressively. when four is placed evalutian happens by the codemaker
require 'colorize'

class Board
    COLORS = [''.red,''.blue,''.yellow,''.green,''.white,''.magenta]
    @@code = 4.times.map { COLORS.sample }
    puts @@code

    def initialize(tries, pegs)
        @tries = tries
        @pegs = pegs
        @board = Array.new(tries) { Array.new(pegs, 0)}
    end

    def display
        @tries.times {  |i| puts "#{@board[i]}" }
    end

    def choose_color
        puts "Choose a color: r/b/y/g/w/m"
        color = gets.chomp
        case color
        when 'r'
        end
    end
end

game = Board.new(12, 4)
game.display
peg_board = Board.new(12, 4)
puts "\n"
peg_board.display