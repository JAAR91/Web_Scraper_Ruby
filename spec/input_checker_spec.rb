# spec..lib/input_checker.rb
require './lib/input_checker'

describe Imputchecker do
  let(:input) { Imputchecker.new }
  describe '#search_result_check' do
    it 'checks the input entered and verify its betwen 1 and the parameter entered' do
      expect(input.search_result_check('5', 10)).to eql('5')
    end
  end

  describe '#search_result_check' do
    it 'check for numbers and empty strings' do
      expect(input.empty_checker('Hello World')).to eql('Hello World')
    end
  end

  describe '#menu_list_checker' do
    it 'checks the input entered its inside the numbers requested' do
      expect(input.menu_list_checker('m', 0, 20, 0, 36)).to eql(['m', 0])
    end
  end

  describe '#menu_list_checker' do
    it 'checks the input entered if its n and return the next page number' do
      expect(input.menu_list_checker('n', 0, 20, 0, 36)).to eql(['n', 20])
    end
  end

  describe '#menu_list_checker' do
    it 'checks the input entered if its b and return the previous page number' do
      expect(input.menu_list_checker('b', 0, 20, 40, 36)).to eql(['b', 20])
    end
  end

  describe '#menu_list_checker' do
    it 'checks the input entered if its a number betwen the numbers requested' do
      expect(input.menu_list_checker('56', 40, 60, 40, 36)).to eql(['56', 40])
    end
  end

  describe '#number_checker' do
    it 'checks the input entered its a number betwen the numbers requested' do
      expect(input.number_checker(11, 0, 20)).to eql(11)
    end
  end

  describe '#empty_checker' do
    it 'makes sure input is never empty and the returns the input entered' do
      expect(input.empty_checker('hi')).to eql('hi')
    end
  end

  describe '#checking_array' do
    it 'return an array of numbers as strings and letters b n or m' do
      expect(input.checking_array(20)).to eql(%w[B N b n m M 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38
                                                 39])
    end
  end

  describe '#back_next' do
    it 'returns the new positition of the page when on index' do
      expect(input.back_next('n', 20, 36)).to eql(40)
    end
  end

  describe '#back_next' do
    it 'returns the new positition of the page when on index' do
      expect(input.back_next('b', 20, 36)).to eql(0)
    end
  end

  describe '#back_next' do
    it 'returns the new positition of the page when on index' do
      expect(input.back_next('b', 0, 2)).to eql(40)
    end
  end

  describe '#back_next' do
    it 'returns the new positition of the page when on index' do
      expect(input.back_next('n', 20, 2)).to eql(0)
    end
  end
end
