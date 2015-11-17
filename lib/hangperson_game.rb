class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word, @guesses, @wrong_guesses = word, '', ''
  end

  def guess(letter)
    raise ArgumentError if !letter || letter.empty? || !letter.match(/[A-Za-z]/)
  
    letter.downcase!
    
    return false if @guesses.index(letter) || @wrong_guesses.index(letter)
    
    if word.index(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end 
  end

  def word_with_guesses
    displayed = ''
    @word.each_char do |letter|
      if @guesses.index(letter)
        displayed << letter
      else
        displayed << '-'
      end
    end
    displayed
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if !word_with_guesses.index('-')  
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
end
