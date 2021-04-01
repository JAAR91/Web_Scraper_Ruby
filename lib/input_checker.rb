# frozen_string_literal: true

# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/AbcSize

require 'byebug'

# class inputchecker
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

  def menu_list_checker(input, initial, last, j_var, page)
    array = %w[B N b n m M]
    result = []
    i_pass = 0
    20.times do |i|
      array.push((i + initial).to_s)
    end
    until i_pass.positive?
      if input.nil?
        puts "Please enter a value from #{initial} to #{last} or N,B or M"
        input = gets.chomp
      elsif array.none?(input)
        puts "Please enter a value from #{initial} to #{last} or N,B or M"
        input = gets.chomp
      elsif %w[b B].any?(input) && j_var.zero?
        puts 'You are already on the first page'
        input = gets.chomp
      elsif %w[n N].any?(input) && ((j_var + 20) / 20) == page
        puts 'You are already on the last page'
        input = gets.chomp
      elsif %w[b B].any?(input) && j_var > 1
        j_var -= 20
        i_pass = 1
      elsif %w[n N].any?(input) && ((j_var + 20) / 20) < page
        j_var += 20
        i_pass = 1
      else
        i_pass = 1
      end
    end
    result.push(input)
    result.push(j_var)
    result
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

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/AbcSize
