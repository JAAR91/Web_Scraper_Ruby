require_relative './input_checker'
require_relative './screen_load'
require 'nokogiri'
require 'httparty'

class Scraper
  attr_reader :parsed

  def initialize
    @parsed = page_scrap
    @load = Progress.new
    @movies = []
    @allmoviesarray = []
    @historical = []
  end

  def menu_index
    index = [[], []]
    array = @parsed.css('table.wikitable').css('tr').css('td').css('a')
    (array.length - 3).times do |i|
      index[0].push(array[i].text)
      index[1].push(array[i].attributes['href'].value)
    end
    index
  end

  def all_movies
    if @allmoviesarray.count.zero?
      index = menu_index
      porcentage = 0
      index[1].each_with_index do |item, indexa|
        porcentage = ((indexa.to_f + 1) / index[1].count.to_f) * 100
        @load.screen_load(porcentage, index[1].count, indexa)
        allmovies = page_scrap(item)
        allmovies.css('div.div-col').css('a').each do |itemb|
          @allmoviesarray.push(itemb)
        end
      end
    end
    @allmoviesarray
  end

  def menu_movies(input)
    parsed = page_scrap(input)
    parsed.css('div.div-col').css('a')
  end

  def movie_profile(input)
    parsed = page_scrap(input)
    array = []
    movieinfo = [[], [], [], []]
    movieinfo[0].push(parsed.css('h1.firstHeading').text)
    array = parsed.css('table.haudio').css('tr').css('th')

    parsed.css('table.infobox').css('tr').each_with_index do |item, _index|
      unless array.text.include?(item.css('th').text)
        movieinfo[1].push(item.css('th').text)
        movieinfo[2].push(item.css('td').text)
      end
    end
    # movieinfo[2].each { |item| item.delete('') if item.is_a?(Array) }
    movieinfo[3].push(parsed.css('div.mw-parser-output').css('p')[1].text)
    @historical.push(movieinfo)
    movieinfo
  end

  def movies_array
    @movies
  end

  def movies_history
    @historical
  end

  def movies_bookmark(array)
    if movie_duplicate(array) == true
      @movies.each_with_index do |item, index|
        @movies.delete_at(index) if item[0][0] == array[0][0]
      end
    else
      @movies.push(array)
    end
  end

  def movie_duplicate(array)
    @movies.each do |item|
      return true if item[0][0] == array[0][0]
    end
    false
  end

  private

  def page_scrap(input = nil)
    unparsed = if input.nil?
                 HTTParty.get('https://en.wikipedia.org/wiki/Lists_of_films#Alphabetical_indices')
               else
                 HTTParty.get("https://en.wikipedia.org#{input}")
               end
    Nokogiri::HTML(unparsed)
  end
end
