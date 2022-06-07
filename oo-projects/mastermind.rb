#pegs have two colors depenging on if its both a color and position hit or just color
#color has to be choosen after which it is placed in the grid.
#placement starts at [0][0], and goes progressively. when four is placed evalutian happens by the codemaker
require 'colorize'

class Board
    @@red = ''.red
    @@blue = ''.blue
    @@yellow = ''.yellow
    @@green =''.green
    @@white = ''.white
    @@magenta =''.magenta
    COLORS = [@@red, @@blue, @@yellow, @@green, @@white, @@magenta]
    @@code = 4.times.map { COLORS.sample }

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
        choice = gets.chomp
        case choice
        when 'r'
            @color_choice = @@red
        when 'b'
            @color_choice = @@blue
        when 'y'
            @color_choice = @@yellow
        when 'g'
            @color_choice = @@green
        when 'w'
            @color_choice = @@white
        when 'm'
            @color_choice = @@magenta
        end
        return @color_choice
    end

    def choose_place 
        puts "Choose a position: 1/2/3/4"
        choice = gets.chomp
        case choice 
        when '1'
            @pos_choice = 0
        when '2'
            @pos_choice = 1
        when '3'
            @pos_choice = 2
        when '4'
            @pos_choice = 3
        end
        return @pos_choice
    end

    def place_color(r=0, c, color)
        @board[r][c] = color
    end
end

game = Board.new(12, 4)
game.display
peg_board = Board.new(12, 4)
puts "\n"
peg_board.display
game.place_color(game.choose_place, game.choose_color)
game.display
