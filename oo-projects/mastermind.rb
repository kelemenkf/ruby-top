#pegs have two colors depenging on if its both a color and position hit or just color
#when four is placed evalution happens by the codemaker
#code and guess compared. evaluated based on position and color
#pegboard manipulation, does it need a different class? 
require 'colorize'

class Board
    @@red = ''.red
    @@blue = ''.blue
    @@yellow = ''.yellow
    @@green =''.green
    @@cyan = ''.cyan
    @@magenta =''.magenta
    @@white = ''.white
    @@black = ''.black
    COLORS = [@@red, @@blue, @@yellow, @@green, @@cyan, @@magenta]
    @@code = 4.times.map { COLORS.sample }
    @@guess = []

    attr_reader :tries, :game_over

    def initialize
        @tries = 12
        @pegs = 4
        @board = Array.new(@tries) { Array.new(@pegs, 0)}
        @game_over = false
    end

    def display
        for i in @board
            puts "#{i[0]} #{i[1]} #{i[2]} #{i[3]}" 
        end
        puts @@code
        puts (@@red == @@blue)
    end

    def choose_color
        puts "Choose a color: r/b/y/g/c/m"
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
        when 'c'
            @color_choice = @@cyan
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

    def play_round(r)
        @pegs.times do 
            self.place_color(r, self.choose_place, self.choose_color)
            self.display
        end
        return @@guess = @board[r]
    end

    def compare(r, guess)
        if @@code == guess
            puts "You won!"
            @game_over = true
        else
            #somehow only one condition is tested but not an and 
            count = guess.count do |peg|
                @@code.include?(peg)
            end
            puts count
            count_black = 0
            guess.zip(@@code).each do |peg, digit|
                if digit == peg 
                    count_black += 1
                end
            end
            puts count_black
            count_white = count - count_black
            puts count_white
            count_black.times do |c|
                place_color(r, c, @@black)
            end
            count_white.times do |c|
                place_color(r, c + count_black, @@white)
            end
        end
    end

    def feedback(r, guess)
        compare(r, guess)
        self.display
    end
end

game = Board.new
peg_board = Board.new
game.display
puts "\n"

game.tries.times do |i|
    guess = game.play_round(i)
    peg_board.feedback(i, guess)
    if peg_board.game_over 
        break
    end
end
