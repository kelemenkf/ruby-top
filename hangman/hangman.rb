class Hangman
    def initialize
        @word = @@wordlist.sample
        @input_field = []
        @word.length.times do 
            @input_field.push('_ ')
        end 
        @input_field = "#{@input_field.join()}"
        @game_over = false
    end

    attr_accessor :word, :input_field, :game_over

    @@wordlist = []
    lines = File.open('wordlist.txt').readlines.each do |line|
        line = line.strip
        if line.length > 4 && line.length < 13
            @@wordlist << line
        end
    end

    def input_letter
        letter = gets.chomp
        @word.length.times do |i|
            if @word[i] == letter
                @input_field[2*i] = letter
            else  
                "Not in word."
            end
        end
    end

    def checking_winner
        if @word == @input_field.gsub(' ', '')
            @game_over = true
            puts "Game over"
        end
    end
end

game = Hangman.new
puts game.input_field
game.input_letter

until game.game_over
    puts game.input_field
    game.input_letter
    game.checking_winner
end