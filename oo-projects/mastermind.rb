# needs incorrect input
require 'colorize'

# Board with colors
class Board
  @@red = ''.red
  @@blue = ''.blue
  @@yellow = ''.yellow
  @@green = ''.green
  @@cyan = ''.cyan
  @@magenta = ''.magenta
  @@white = ''.white
  @@black = ''.black
  COLORS = [@@red, @@blue, @@yellow, @@green, @@cyan, @@magenta]
  @@code = 4.times.map { COLORS.sample }
  @@guess = []

  attr_reader :tries, :game_over

  def initialize
    @tries = 12
    @pegs = 4
    @board = Array.new(@tries) { Array.new(@pegs, 0) }
    @game_over = false
  end

  # Displays board, with four items in a row
  def display
    for i in @board
      puts "#{i[0]} #{i[1]} #{i[2]} #{i[3]}"
    end
    puts @@code
  end

  # User input for color choice
  def choose_color
    puts 'Choose a color: r/b/y/g/c/m'
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
    @color_choice
  end

  # User input for chossing place of peg
  def choose_place
    puts 'Choose a position: 1/2/3/4'
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
    @pos_choice
  end

  # Places the peg
  def place_color(r = 0, c, color)
    @board[r][c] = color
  end

  # One round with choice and placement
  def play_round(r)
    @pegs.times do
      place_color(r, choose_place, choose_color)
      display
    end
    @@guess = @board[r]
  end

  # Comparing of code to guess, and placing indicator pegs
  def compare(r, guess)
    if @@code == guess
      puts 'You won!'
      @game_over = true
    else
      count = 0
      test_guess = guess.clone
      test_code = @@code.clone
      for i in guess
        peg = test_guess.shift
        if test_code.include?(peg)
          count += 1
          test_code.delete_at(test_code.index(peg))
        end
      end
      p count
      count_black = 0
      guess.zip(@@code).each do |peg, digit|
        count_black += 1 if digit == peg
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

  # Displays the feedback
  def feedback(r, guess)
    compare(r, guess)
    display
  end
end

game = Board.new
peg_board = Board.new
game.display
puts "\n"

# Main game loop
game.tries.times do |i|
  guess = game.play_round(i)
  peg_board.feedback(i, guess)
  if peg_board.game_over
    break
  elsif peg_board.game_over == false && i == 11
    puts 'You lose'
    break
  end
end
