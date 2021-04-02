require_relative '../lib/scraper'
require_relative '../lib/input_checker'

@input_checker = Inputchecker.new
@movies = Scraper.new

def main_menu
  @input_checker.display_clear
  print_menu
  input = @input_checker.number_checker(gets.chomp.to_i, 1, 5)
  case input
  when 1
    movie_index_by
  when 2
    search_options
  when 3
    instructions_menu
  when 4
    credits
  when 5
    exit_game
  end
end

def print_menu
  puts '+-----------------------------+'
  puts '|          Main Menu          |'
  puts '+-----------------------------+'
  puts '1. Show index'
  puts '2. Search options'
  puts '3. About'
  puts '4. Credits'
  puts '5. Exit'
  puts '+------------------------------+'
  puts '| select a number from 1 to 5  |'
  puts '+------------------------------+'
end

def credits
  @input_checker.display_clear
  puts '+---------------------------------+'
  puts '|            CREDITS              |'
  puts '+---------------------------------+'
  puts '|   All credits to:               |'
  puts '|                        JAAR     |'
  puts '|                                 |'
  puts '|   Microverser 2021              |'
  puts '+---------------------------------+'
  print 'Press enter to go back...'
  gets
  main_menu
end

def instructions_menu
  @input_checker.display_clear
  boxing('   About Movie Web Scraper  ')
  instructions_partone
  instructions_parttwo
  gets
  main_menu
end

def instructions_partone
  puts '+----------------------------+'
  puts '|This program was made as a  |'
  puts '|project to scrape a page    |'
  puts '|about movies                |'
  puts '|                            |'
  puts '|The main program contains   |'
  puts '|two options to search       |'
  puts '|                            |'
  puts '|The first one is an index   |'
  puts '|in alphabetical order to    |'
  puts '|search movies by index      |'
  puts '|the result will be returned |'
  puts '|in pages, with 20 results   |'
end

def instructions_parttwo
  puts '|per page, you either choose |'
  puts '|a movie from the results    |'
  puts '|displayed or go back and    |'
  puts '|forward on the pages        |'
  puts '|                            |'
  puts '|The second option is a      |'
  puts '|search option by name, the  |'
  puts '|result will show the amount |'
  puts '|of movies that include that |'
  puts '|name and an option to open  |'
  puts '|the profile for each of the |'
  puts '|results                     |'
  puts '+----------------------------+'
  print 'Press enter to go back.......'
end

def search_options
  array = @movies.all_movies
  ans = nil
  until %w[m M].any?(ans)
    @input_checker.display_clear
    puts '+------------------------------------------------+'
    puts '|            Search by Name                      |'
    puts '+------------------------------------------------+'
    puts '|Enter the name of the movie you are looking for |'
    puts '|or enter m to go back to the menu               |'
    puts '+------------------------------------------------+'
    ans = @input_checker.empty_checker(gets.chomp)
    unless %w[m M].any?(ans)
      results_array = search_name(array, ans)
      print_search_results(results_array, ans)
    end
  end
  main_menu
end

def search_name(array, input)
  my_array = [[], []]
  array.each do |item|
    if item.text.include?(input.capitalize)
      my_array[0].push(item.text)
      my_array[1].push(item.attributes['href'].value)
    end
  end
  my_array
end

def print_search_results(my_array, input)
  until input.nil? || input == ''
    @input_checker.display_clear
    boxing("#{my_array[0].count} results found with #{input}")
    my_array[0].each_with_index { |item, index| puts "#{index + 1}. #{item}" }
    boxing('Enter a number to see the movie profile or press enter to go back')
    input = @input_checker.search_result_check(gets.chomp, my_array[0].count)
    movie_info(my_array[1][input.to_i - 1]) if !input.nil? && input != ''
  end
end

def movie_index_by
  index = @movies.menu_index
  @input_checker.display_clear
  puts '+----------------------------+'
  puts '| Movies by Index            |'
  puts '+----------------------------+'
  index[0].each_with_index { |item, i| puts "#{i + 1}. #{item}" }
  puts '+----------------------------+'
  puts "| Select and Option(1 to #{index[0].count}) |"
  puts '+----------------------------+'
  ans = @input_checker.number_checker(gets.chomp.to_i, 1, index[0].count)
  link = ''
  name = ''
  @movies.menu_index[0].each_with_index do |item, i|
    name = item if i == (ans - 1)
  end
  @movies.menu_index[1].each_with_index do |item, i|
    link = item if i == (ans - 1)
  end
  print_movies(link, name)
end

def print_movies(link, name)
  array = @movies.menu_movies(link)
  ans = ['x']
  i = 0
  while i < array.length && %w[m M].none?(ans[0])
    @input_checker.display_clear
    page = array.count / 20
    boxing("All movies for #{name} and a total of #{array.count} movies")

    array.each_with_index do |item, index|
      puts "#{index + 1}. #{item.text}" if index >= i && index <= (i + 19)
    end
    boxing("Page #{(i + 20) / 20} of #{page} pages")
    print_movies_options
    ans = @input_checker.menu_list_checker(gets.chomp, i + 1, i + 20, i, page)
    i = ans[1]
    s = []
    (i + 20 + 1).times { |item| s.push(item.to_s) }
    movie_info(array[(ans[0].to_i - 1)].attributes['href'].value) if s.any?(ans[0])
  end
  main_menu
end

def movie_info(link)
  array = @movies.movie_profile(link)
  @input_checker.display_clear
  boxing(array[0][0].to_s)
  puts ''
  array[1].each_with_index do |item, index|
    puts "   #{index + 1}.#{item}"
    print '+---'
    index.to_s.chars.each { |_i| print '-' }
    item.chars.each { |_i| print '-' }
    puts '---+'
    array[2][index + 1].each { |itemb| puts "-> #{itemb}" }
    puts ''
  end
  puts '+--------Info----------+'
  puts array[3]
  puts ''
  print 'Press enter to go back...'
  gets
end

def print_movies_options
  puts '+--------------------------------------------+'
  puts '| Press B for previous results               |'
  puts '| Press N for next results                   |'
  puts '| Press M to go back to the Menu             |'
  puts '+--------------------------------------------+'
end

def exit_game
  @input_checker.display_clear
  puts '+--------------------------------------+'
  puts '| Thank you for using this web scraper |'
  puts '|                             Good-Bye |'
  puts '+--------------------------------------+'
end

def boxing(input)
  print '+'
  input.length.times { print '-' }
  puts '+'
  puts "|#{input}|"
  print '+'
  input.length.times { print '-' }
  puts '+'
end

def main_screen
  @input_checker.display_clear
  puts '+----------------------------------------------------------------+'
  puts '|     *lll   lll   lll     lllllllllll       llllllllll          |'
  puts '|      lll   lll   lll     llll              llll    llll        |'
  puts '|      lll   lll   lll     lllllllll         lllllllllll         |'
  puts '|       llll lll  llll     llll              llll    llll        |'
  puts '|         llllllllllll     lllllllllll       llllllllll          |'
  puts '|                                                                |'
  puts '|   SSSSS    CCCCCC   RRRR      AAA    PPPP   EEEEE   RRRR       |'
  puts '|  SS        CC       R   R    A   A   P   P  E       R   R      |'
  puts '|   SSSSS    CC       RRRR     AAAAA   PPPP   EEEE    RRRR       |'
  puts '|       SS   CC       R   R    A   A   P      E       R   R      |'
  puts '|   SSSSS    CCCCCC   R    R   A   A   P      EEEEE   R   R      |'
  puts '|                                                                |'
  puts '+----------------------------------------------------------------+'
  puts 'press any key to continue'
  gets
  main_menu
end

main_screen
