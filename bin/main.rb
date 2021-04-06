require_relative '../lib/scraper'
require_relative '../lib/input_checker'
require 'byebug'

@input_checker = Inputchecker.new
@movies = Scraper.new

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
  puts '|                                                            2021|'
  puts '+----------------------------------------------------------------+'
  puts 'press any key to continue'
  gets
  main_menu
end

def print_menu
  puts '+-----------------------------+'
  puts '|          Main Menu          |'
  puts '+-----------------------------+'
  puts '1. Show index'
  puts '2. Search options'
  puts '3. About'
  puts '4. Credits'
  puts '5. Bookmarks'
  puts '6. Exit'
  puts '+------------------------------+'
  puts '| select a number from 1 to 5  |'
  puts '+------------------------------+'
end

def main_menu
  @input_checker.display_clear
  print_menu
  input = @input_checker.number_checker(gets.chomp.to_i, 1, 6)
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
    movie_bookmarks
  when 6
    exit_game
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
  print_movies(index[0][ans - 1], index[1][ans - 1])
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

def instructions_menu
  @input_checker.display_clear
  boxing('   About Movie Web Scraper  ')
  instructions_partone
  instructions_parttwo
  gets
  main_menu
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

def movie_bookmarks
  array = @movies.movies_array
  ans = nil
  page = 0
  t_page = page_count(array.count)
  until %w[m M].any?(ans)
    @input_checker.display_clear
    boxing("Movies Bookmarked a total of #{array.count} movies saved")
    puts "+-------------page #{page + 1} of #{t_page}----------------+"
    print_movies_bookmarks(array, page)
    puts "+-------------page #{page + 1} of #{t_page}----------------+"
    movie_bookmarks_options
    ans = @input_checker.menu_list_checker(gets.chomp, page, %w[a A f F m M b B n N])
    page = page_back(page, t_page) if %w[b B].any?(ans)
    page = page_next(page, t_page) if %w[n N].any?(ans)
  end
  main_menu
end

def print_movies_bookmarks(array, page)
  array.each_with_index do |item, index|
    puts "#{index + 1}. #{item[0][0]}" if index >= page * 20 && index <= ((page * 20) + 20)
  end
end

def movie_bookmarks_options
  puts '+--------------------------------------+'
  puts '|Enter a number to select a movie      |'
  puts '|Enter F to see all movies information |'
  puts '|Enter M to go back to the Menu        |'
  puts '+--------------------------------------+'
end

def page_array(page)
  array = []
  20.times do |item|
    array.push(((page * 20) + item + 1).to_s)
  end
  array
end

def exit_game
  @input_checker.display_clear
  puts '+--------------------------------------+'
  puts '| Thank you for using this web scraper |'
  puts '|                                      |'
  puts '|                             Good-Bye |'
  puts '|                                      |'
  puts '+--------------------------------------+'
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

def print_movies(name, link)
  array = @movies.menu_movies(link)
  ans = 'x'
  page = 0
  while %w[m M].none?(ans)
    @input_checker.display_clear
    t_page = page_count(array.count)
    boxing("All movies for #{name} and a total of #{array.count} movies")
    puts "+--------------page #{page + 1} of #{t_page}------------------+"
    print_movies_index(array, page)
    puts "+--------------page #{page + 1} of #{t_page}------------------+"
    print_movies_options
    ans = @input_checker.menu_list_checker(gets.chomp, page, %w[B N b n m M])
    page = page_back(page, t_page) if %w[b B].any?(ans)
    page = page_next(page, t_page) if %w[n N].any?(ans)
    movie_info(array[(ans.to_i - 1)].attributes['href'].value) if page_array(page).any?(ans)
  end
  main_menu
end

def print_movies_index(array, page)
  array.each_with_index do |item, index|
    puts "#{index + 1}. #{item.text}" if index >= (page * 20) && index <= ((page * 20) + 19)
  end
end

def page_back(page, t_page)
  return t_page - 1 if page.zero?
  return page - 1 if page.positive?
end

def page_next(page, t_page)
  return 0 if page == (t_page - 1)
  return page + 1 if page < t_page
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

def page_count(items_c)
  if (items_c % 20).zero?
    items_c / 20
  else
    (items_c / 20) + 1
  end
end

def movie_info(link)
  array = @movies.movie_profile(link)
  ans = nil
  while ans != ''
    @input_checker.display_clear
    print_movie_info(array)
    movie_profile_options(array)
    ans = @input_checker.movie_profile_checker(gets.chomp, ['b', 'B', ''])
    @movies.movies_bookmark(array) if %w[b B].any?(ans)
  end
end

def print_movie_info(array)
  minus_signs(50)
  movie_tittle(array[0][0])
  minus_signs(50)
  array[1].each_with_index do |item, index|
    minus_signs(50)
    puts "#{index + 1}.#{item}:"
    if array[2][index].is_a?(Array)
      array[2][index].each do |itemb|
        puts itemb
      end
    else
      puts array[2][index]
    end
  end
  minus_signs(103)
  movie_small_info(array[3][0])
  minus_signs(103)
end

def movie_tittle(array)
  print '|'
  (25 - (array.length / 2)).times { print ' ' }
  print array.to_s
  (25 - (array.length / 2)).times { print ' ' }
  puts '|'
end

def minus_signs(amount)
  print '+'
  amount.times { print '-' }
  puts '+'
end

def movie_small_info(array)
  words_count = 0
  array.split.each do |item|
    print ' ' if words_count.zero?
    print item
    if words_count >= 90
      puts ''
      words_count = 0
    else
      print ' '
      words_count = words_count + item.length + 1
    end
  end
  puts ''
end

def movie_profile_options(name)
  if @movies.movie_duplicate(name) == true
    puts '+--------------------------------+'
    puts '|Press Enter to go back          |'
    puts '|Press B to unbookmark this movie|'
    puts '+--------------------------------+'
  else
    puts '+------------------------------+'
    puts '|Press Enter to go back        |'
    puts '|Press B to bookmark this movie|'
    puts '+------------------------------+'
  end
end

def print_movies_options
  puts '+--------------------------------------------+'
  puts '| Press B for previous results               |'
  puts '| Press N for next results                   |'
  puts '| Press M to go back to the Menu             |'
  puts '+--------------------------------------------+'
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

main_screen
