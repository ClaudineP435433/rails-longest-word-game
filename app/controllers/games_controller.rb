require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
    @total = session[:total_score] || 0
  end

  def score
    @total = session[:total_score] || 0
    @word = params[:word]
    @words = params[:word].upcase.split("")
    @randletters = params[:letterslist].split("")
    result = 0

    @words.each do |x|
      if @randletters.include? x
        result += 1
      end
    end

    # check valid word
    if @words.size != result
      return @score = "Invalid answer - this word is not in the grid"
    end
    # check word in english
    test = checkword(@word)
    if test["found"] == true
      @total += @word.size
      session[:total_score] = @total
      return @score = " Congratulations !!"
    else
      return @score = "Invalid answer - this word is not an english word"
    end
  end


  def checkword(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    user_serialized = open(url).read
    check = JSON.parse(user_serialized)
    return check
  end

end
