require 'byebug'

class Inputchecker
  require 'rbconfig'
  include RbConfig

  def display_clear
    case CONFIG['host_os']
    when /mswin|windows/i
      system('clr')
    when /linux|arch/i
      system('clear')
    end
  end

  def search_result_check(input, last)
    array = [nil, '']
    last.times do |i|
      array.push((i + 1).to_s)
    end
    until array.any?(input)
      puts "Please enter a number betwen 1 to #{last} or press enter to go back"
      input = gets.chomp
    end
    input
  end

  def empty_checker(input)
    while input.nil? || input == ''
      puts 'Please enter a value'
      input = gets.chomp
    end
    input
  end

  def checking_array(page, my_array)
    array = my_array
    20.times { |i| array.push(((page * 20) + i + 1).to_s) }
    array
  end

  def menu_list_checker(input, page, array)
    until checking_array(page, array).any?(input)
      puts "Please enter a value from #{page * 20} to #{(page * 20) + 20} or N,B or M"
      input = gets.chomp
    end
    input
  end

  def movie_profile_checker(input, array)
    until array.any?(input)
      puts 'Please enter a valid value!:'
      input = gets.chomp
    end
    input
  end

  def number_checker(input, initial, last)
    array = []

    (initial..last).each do |i|
      array.push(i)
    end

    until !input.nil? && input.is_a?(Integer) && array.any?(input)
      print "Please enter only numbers beetwen #{initial} and #{last} please!!:"
      input = gets.chomp.to_i
    end
    input
  end
end
