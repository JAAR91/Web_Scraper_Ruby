# spec..lib/scraper.rb
require './lib/scraper'

describe Scraper do
  let(:scraper) { Scraper.new }
  let(:array) do
    [[' 0-9 ', ' A ', ' B ', ' C ', ' D ', ' E ', ' F ', ' G ',
      ' H ', '  I  ', 'J–K', ' L ', ' M ', 'N–O', ' P ', 'Q–R',
      ' S ', ' T ', 'U-V-W', 'X–Y–Z'],
     ['/wiki/List_of_films:_numbers', '/wiki/List_of_films:_A', '/wiki/List_of_films:_B', '/wiki/List_of_films:_C',
      '/wiki/List_of_films:_D', '/wiki/List_of_films:_E', '/wiki/List_of_films:_F', '/wiki/List_of_films:_G',
      '/wiki/List_of_films:_H', '/wiki/List_of_films:_I', '/wiki/List_of_films:_J%E2%80%93K',
      '/wiki/List_of_films:_L', '/wiki/List_of_films:_M', '/wiki/List_of_films:_N%E2%80%93O',
      '/wiki/List_of_films:_P', '/wiki/List_of_films:_Q%E2%80%93R', '/wiki/List_of_films:_S',
      '/wiki/List_of_films:_T', '/wiki/List_of_films:_U%E2%80%93W', '/wiki/List_of_films:_X%E2%80%93Z']]
  end

  describe '#menu_index' do
    it 'return am array with all index options on the page and its links' do
      expect(scraper.menu_index[1]).to match_array(array[1])
    end

    it 'return am array with all index options on the page and its links' do
      expect(scraper.menu_index[0].class).to eq(Array)
    end
  end

  describe '#all_movies' do
    it 'returns a array with two arrays, one for the name fo the movies and another one for the links' do
      expect(scraper.all_movies.class).to eq(Array)
    end
  end

  describe '#menu_movies' do
    it 'returns an array with the names of the movies for index' do
      expect(scraper.menu_movies('/wiki/List_of_films:_numbers').class).to eq(Nokogiri::XML::NodeSet)
    end
  end
end
