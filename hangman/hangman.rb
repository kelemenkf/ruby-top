require 'yaml'

class Hangman
  def initialize
    @word = @@wordlist.sample
    @input_field = []
    @word.length.times do
      @input_field.push('_ ')
    end
    @input_field = "#{@input_field.join}"
    @game_over = false
    @wrong_counter = 0
    @used_letters = []
    @game_saved = false
    @game_reloaded = false
    @letter = ''
  end

  attr_accessor :word, :input_field, :game_over, :game_saved, :wrong_counter, :used_letters, :game_reloaded, :letter

  @@wordlist = []
  lines = File.open('wordlist.txt').readlines.each do |line|
    line = line.strip
    @@wordlist << line if line.length > 4 && line.length < 13
  end

  def input_letter
    @letter = gets.chomp.downcase
    if @letter == 'save'
      serialized = self.to_yaml
      save(serialized)
      @game_saved = true
    elsif @letter == 'reload'
        @game_saved = false
        @game_reloaded = true
    elsif @used_letters.include?(@letter)
      puts 'Already used!'
    elsif @used_letters << @letter
      @word.length.times do |i|
        @input_field[2 * i] = @letter if @word[i] == @letter
      end
      unless @word.include?(@letter)
        @wrong_counter += 1
        puts "Number of wrong guess: #{@wrong_counter}"
      end
    end
  end

  def checking_winner
    if @word == @input_field.gsub(' ', '')
      @game_over = true
      puts 'Game over'
      puts "#{word}"
    elsif @wrong_counter == 12
      @game_over = true
      puts 'You lose'
      puts "The word was #{word}"
    end
  end

  def to_yaml
    YAML.dump(self)
  end

  def save(serialized)
    fname = gets.chomp
    saved_game = File.open("#{fname}.yaml", 'w')
    saved_game.puts serialized
    saved_game.close
  end

  def self.reload(file)
    File.open(file) do |f|
        data = YAML.load(f)
        return data
    end
  end
end

game = Hangman.new
puts 'To save type save, to reload type reload'

until game.game_over
  puts game.input_field
  game.input_letter
  game.checking_winner
  if game.game_saved
    break
  elsif game.game_saved == false && game.game_reloaded == true && game.letter.length > 1
    puts "Choose a file"
    file = gets.chomp.to_i
    game = Hangman.reload("#{file}.yaml")
  end
end
