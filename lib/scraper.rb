# frozen_string_literal: true

require_relative './input_checker'
require 'nokogiri'
require 'httparty'
require 'byebug'

class Scrapper
  def initialize
    unparsed = HTTParty.get('https://en.wikipedia.org/wiki/Lists_of_films#Alphabetical_indices')
    @parsed = Nokogiri::HTML(unparsed)
  end

  def menu_index
    @index = []
    name = []
    links = []
    array = @parsed.css('table.wikitable').css('tr').css('td').css('a')
    (array.length - 3).times do |i|
      name.push(array[i].text)
      links.push(array[i].attributes['href'].value)
    end
    @index.push(name)
    @index.push(links)
    @index
  end

  def all_movies
    allmoviesarray = []
    input = Imputchecker.new

    index = @parsed.css('table.wikitable').css('tr').css('td').css('a')
    index.pop
    index.pop
    index.pop
    index.each_with_index do |item, index|
      input.display_clear
      puts index
      unparsed = HTTParty.get("https://en.wikipedia.org#{item.attributes['href'].value}")
      allmovies = Nokogiri::HTML(unparsed)

      allmovies.css('div.div-col').css('a').each do |itemb|
        allmoviesarray.push(itemb)
      end
    end
    allmoviesarray
  end

  def menu_movies(input)
    unparsed = HTTParty.get("https://en.wikipedia.org#{input}")
    parsed = Nokogiri::HTML(unparsed)
    array = parsed.css('div.div-col').css('a')
    array
  end

  def movie_profile(input)
    unparsed = HTTParty.get("https://en.wikipedia.org#{input}")
    parsed = Nokogiri::HTML(unparsed)
    array = []
    movieinfo = [[], [], [], []]
    movieinfo[0].push(parsed.css('h1.firstHeading').text)

    parsed.css('table.infobox').css('tr').each do |item|
      unless parsed.css('table.haudio').css('tr').css('th').text.include?(item.css('th').text)
        movieinfo[1].push(item.css('th').text)
      end
      unless parsed.css('table.haudio').css('tr').css('th').text.include?(item.css('th').text)
        movieinfo[2].push(item.css('td').text.split("\n"))
      end
    end
    movieinfo[1].shift
    movieinfo[2].each { |item| item.delete('') if item.is_a?(Array) }
    movieinfo[3].push(parsed.css('div.mw-parser-output').css('p')[1].text)
    movieinfo
  end
end
