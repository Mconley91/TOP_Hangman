class Game
    attr_accessor(:game_board, :strikes, :secret_word, :guess, :victory)
    def initialize
        @game_board = []
        @strikes = 0
        @secret_word = ''
        @guess = ''
        @victory = false
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
        puts 'Enter a letter to decode the secret word!'
        self.guess = gets.chomp.upcase
        if secret_word.include?(guess)
          arr_of_indexes = []
          secret_word.each_with_index do|letter, index| 
            if letter == guess 
            arr_of_indexes << index
            end
          end
          arr_of_indexes.each {|indexer| self.game_board[indexer] = guess}
        else
          puts "Incorrect guess! Strikes: #{self.strikes += 1}"
        end
    end

    def is_winner?
      if game_board == secret_word
        puts 'You win!'
        self.victory = true
      end
    end

    def draw_board
        self.game_board = Array.new(secret_word.length, '_')
    end

    def play_game
        puts "The secret word is: #{secret_word.join('')}"
        puts "START: #{game_board}"
        until victory do
            self.handle_turn
            p self.secret_word
            p self.game_board
            if is_winner?
              break
            end
        end
    end
end

current_game = Game.new()
current_game.generate_secret_word
current_game.draw_board
current_game.play_game

