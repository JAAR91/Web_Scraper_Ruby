class Imputchecker
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

  def checking_array(initial)
    array = %w[B N b n m M]
    20.times { |i| array.push((i + initial).to_s) }
    array
  end

  def menu_list_checker(input, initial, last, j_var, page)
    result = []
    i_pass = 0
    until i_pass.positive?
      if input.nil? || checking_array(initial).none?(input)
        puts "Please enter a value from #{initial} to #{last} or N,B or M"
        input = gets.chomp
      else
        i_pass = 1
      end
      j_var = back_next(input, j_var, page)
    end
    result.push(input)
    result.push(j_var)
    result
  end

  def back_next(input, j_var, page)
    if %w[b B].any?(input)
      j_var = page * 20 if j_var.zero?
      j_var -= 20 if j_var > 1
    elsif %w[n N].any?(input)
      j_var += 20 if ((j_var + 20) / 20) < page
      j_var = 0 if ((j_var + 20) / 20) == page
    end
    j_var
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
