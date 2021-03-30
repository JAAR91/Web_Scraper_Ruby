require_relative '../lib/scraper'
require_relative '../lib/input_checker'

@input_checker = Imputchecker.new
@movies = Scrapper.new

def main_menu
  @input_checker.display_clear
  puts 'Main Menu'
  puts '+---------------------+'
  puts '1. Show index'
  puts '2. Search options'
  puts '3. All movies'
  puts '4. Credits'
  puts '5. Exit'
  puts '+---------------------+'
  input = @input_checker.number_checker(gets.chomp.to_i, 1,5)
  case input
  when 1
    movie_index_by
  when 2
  when 3
  when 4
  when 5
    exit_game
  end
end

def movie_index_by
  index = @movies.menu_index
  amount = @movies.movies_amount
  @input_checker.display_clear
  puts '+---------------------+'
  puts 'Select an option'
  index[0].each_with_index { |item, i| puts "#{i + 1}. #{item} (#{amount[i]} movies)"}
  puts '+---------------------+'
  ans = @input_checker.number_checker(gets.chomp.to_i, 1, index.length + 1)
  link = ''
  name = ''
  @movies.menu_index[0].each_with_index {|item, index| name = item if index == (ans - 1)}
  @movies.menu_index[1].each_with_index {|item, index| link = item if index == (ans - 1)}
  print_movies(link, name)
end

def print_movies(link, name)
  array = @movies.menu_movies(link)
  i = 0
  while i < array[0].length
  @input_checker.display_clear
  p array[0].length
  puts '+-------------------------------+'
  puts "All movies for #{name} from #{i + 1} to #{i + 20}"
  array[0].each_with_index {|item, index| puts "#{index + 1}. #{item}" if index >= i && index <= (i + 19) }
  puts '+-------------------------------+'
  puts 'Press B for previous result of N for next:'
  puts '+-------------------------------+'
  ans = @input_checker.number_checker(gets.chomp, i + 1, i + 20)
  
  if ans.upcase == "B"
    i += 20 
  elsif ans.upcase == 'N'
    i -= 20
  end

  end

end

def exit_game
  puts 'Good Bye'
end

def main_screen
  @input_checker.display_clear
  puts 'hello welcome to wikipedia movie web scrapper'
  puts 'press any key to continue'
  gets
  main_menu
end

main_screen
