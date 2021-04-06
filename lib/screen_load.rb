require_relative './input_checker'

class Progress
  def initialize
    @input = Inputchecker.new
  end

  def screen_load(porcentage, index, indexa)
    @input.display_clear
    puts '+----------------------------------------------+'
    puts '|                                              |'
    print '|    Loading Movies'
    print "  #{porcentage.to_i}" if porcentage < 10
    print " #{porcentage.to_i}" if porcentage > 9 && porcentage < 100
    print porcentage.to_i.to_s if porcentage > 99
    puts '%                        |'
    print '|   '
    (index * 2).times do |j|
      print '▓' if j < ((indexa + 1) * 2)
      print '░' if j >= ((indexa + 1) * 2)
    end
    puts '   |'
    puts '|                                              |'
    puts '+----------------------------------------------+'
  end
end
