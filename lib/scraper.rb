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

  def movies_amount
    amount = []
    @index[1].each_with_index do |item, i|
      unparsed = HTTParty.get("https://en.wikipedia.org/#{@index[1][i]}")
      parsed = Nokogiri::HTML(unparsed)
      amount[i] = parsed.css('div.div-col').css('a').count
    end
    amount
  end

  def menu_movies(input)
    unparsed = HTTParty.get("https://en.wikipedia.org/#{input}")
    parsed = Nokogiri::HTML(unparsed)
    name = []
    links = []
    result = []
    array = parsed.css('div.div-col').css('a')
    array.length.times do |i|
      name.push(array[i].text)
      links.push(array[i].attributes['href'].value)
    end
    result.push(name)
    result.push(links)
    result
  end
end
