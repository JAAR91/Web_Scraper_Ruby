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

  def number_checker(input, initial, last)
    unless !input.nil? || input.is_a?(Integer) || input_checker.upcase == 'N' || input_checker.upcase == 'B' || input.to_i >= initial && input.to_i <= last
      puts "Please enter a valid number between #{initial} and #{last}!!!"
      input = gets.chomp
    end
    input
  end
end
