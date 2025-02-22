def start_game
    dictionary = File.read('google-10000-english-no-swears.txt').split(" ")
    secret_word = ''
    until word.length > 5 && word.length < 12
      secret_word = dictionary.sample.chomp
    end
    secret_word
end

start_game