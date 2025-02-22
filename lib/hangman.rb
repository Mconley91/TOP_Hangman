class Game
    attr_accessor(:game_board, :turn, :secret_word, :guess)
    def initialize
        @game_board = []
        @turn = 0
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
        puts 'Enter a letter to decode the secret word!'
        self.guess = gets.chomp
    end

    def draw_board
        self.game_board = Array.new(secret_word.length, '_')
    end
end

current_game = Game.new()

current_game.generate_secret_word
current_game.draw_board
p current_game.secret_word
p current_game.game_board
