require 'yaml'

class Hangman
    def initialize
        @word = @@wordlist.sample
        @input_field = []
        @word.length.times do 
            @input_field.push('_ ')
        end 
        @input_field = "#{@input_field.join()}"
        @game_over = false
        @wrong_counter = 0
        @used_letters = []
        @game_saved = false
    end

    attr_accessor :word, :input_field, :game_over, :game_saved

    @@wordlist = []
    lines = File.open('wordlist.txt').readlines.each do |line|
        line = line.strip
        if line.length > 4 && line.length < 13
            @@wordlist << line
        end
    end

    def input_letter
        letter = gets.chomp.downcase
        if letter.length > 1
            serialized = self.to_yaml
            save(serialized)
            @game_saved = true
        else
            if @used_letters.include?(letter)
                puts "Already used!"
            elsif
                @used_letters << letter
                @word.length.times do |i|
                    if @word[i] == letter
                        @input_field[2*i] = letter
                    end
                end
                if !@word.include?(letter)
                    @wrong_counter += 1
                    puts "Number of wrong guess: #{@wrong_counter}"
                end
            end
        end
    end

    def checking_winner
        if @word == @input_field.gsub(' ', '')
            @game_over = true
            puts "Game over"
            puts "#{word}"
        elsif
            @wrong_counter == 12
            @game_over = true
            puts "You lose"
            puts "The word was #{word}"
        end
    end

    def to_yaml
        YAML.dump ({
            :word => @word,
            :input_field => @input_field,
            :game_over => @game_over,
            :wrong_counter => @wrong_counter,
            :used_letters => @used_letters
        })
    end

    def save(serialized)
        saved_game = File.open('saved.yaml', 'w')
        saved_game.puts serialized
        saved_game.close
    end

end

game = Hangman.new
puts "To save type save"
puts game.input_field
game.input_letter

until game.game_over
    puts game.input_field
    game.input_letter
    game.checking_winner
    if game.game_saved
        break
    end
end