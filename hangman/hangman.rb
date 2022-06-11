class Hangman
    def initialize
        @word = @@wordlist.sample
        @input_field = []
        @word.length.times do 
            @input_field.push('_ ')
        end 
        @input_field = "#{@input_field.join()}"
    end

    attr_accessor :word, :input_field

    @@wordlist = []
    lines = File.open('wordlist.txt').readlines.each do |line|
        line = line.strip
        if line.length > 4 && line.length < 13
            @@wordlist << line
        end
    end
end

game = Hangman.new
puts game.word
puts game.word.length
puts game.input_field