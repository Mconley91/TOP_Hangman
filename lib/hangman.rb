class Game
  attr_accessor(:game_board, :strikes, :secret_word, :guess)
  def initialize
    @game_board = []
    @strikes = 0
    @secret_word = ''
    @guess = ''
  end

  def generate_secret_word
    dictionary = File.read('google-10000-english-no-swears.txt').split(" ")
    word = ''
    until word.length > 5 && word.length < 12
      word = dictionary.sample.chomp
    end
    self.secret_word = word.upcase.split('')
  end

  def handle_turn
    self.guess = gets.chomp.upcase
    if guess == 'SAVE'
      save_game
    elsif guess == 'LOAD'
        load_game
    else
      if secret_word.include?(guess)
        arr_of_indexes = []
        secret_word.each_with_index do|letter, index| 
          if letter == guess 
          arr_of_indexes << index
          end
        end
        arr_of_indexes.each {|indexer| self.game_board[indexer] = guess}
      else
        puts "Incorrect guess! Tries Left: #{7 - (self.strikes += 1)}"
      end
      p self.game_board
    end
  end

  def is_winner_or_loser?
    if game_board == secret_word
      puts 'You win!'
      return true
    end
    if strikes == 7
      puts "You lose! The secret word was #{secret_word.join('')}"
      return true
    end
  end

  def draw_board
    self.game_board = Array.new(secret_word.length, '_')
  end

  def play_game
    puts "START: #{game_board}"
    until is_winner_or_loser? do
      # puts "CHEAT: #{self.secret_word}"
      self.handle_turn
    end
  end

  def save_game
    game_states = [game_board.join(''), strikes.to_s, secret_word.join(''), guess.to_s]
    Dir.mkdir('saves') unless Dir.exist?('saves')
    File.open('saves/saved_game.txt', 'w') do |file|
      file.puts game_states
    end
    puts "Game Saved!"
  end

  def load_game
    game_info = File.read('saves/saved_game.txt').split(/\n/)
    self.game_board = game_info[0].split('')
    self.strikes = game_info[1].to_i
    self.secret_word = game_info[2].split('')
    self.guess = game_info[3]
    puts 'Game Loaded!'
    p game_board
  end
end

current_game = Game.new()
current_game.generate_secret_word
current_game.draw_board
puts 'Enter a letter to decode the secret word! Type SAVE or LOAD to save or load a previous session.'
current_game.play_game