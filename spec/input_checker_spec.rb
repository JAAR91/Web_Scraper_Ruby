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
    it 'checks the input entered its not empty' do
        expect(input.empty_checker('Hello World')).to eql('Hello World')
    end
  end

  describe '#menu_list_checker' do
    it 'checks the input entered its inside the numbers requested' do
        expect(input.menu_list_checker('m', 0 , 20 , 0, 36)).to eql(['m', 0])
    end
  end

  describe '#menu_list_checker' do
    it 'checks the input entered if its n and return the next page number' do
        expect(input.menu_list_checker('n', 0 , 20 , 0, 36)).to eql(['n', 20])
    end
  end

  describe '#menu_list_checker' do
    it 'checks the input entered if its b and return the previous page number' do
        expect(input.menu_list_checker('b', 0 , 20 , 40, 36)).to eql(['b', 20])
    end
  end

  describe '#menu_list_checker' do
    it 'checks the input entered if its a number betwen the numbers requested' do
        expect(input.menu_list_checker('56', 40 , 60 , 40, 36)).to eql(['56', 40])
    end
  end

  describe '#number_checker' do
    it 'checks the input entered its a number betwen the numbers requested' do
        expect(input.number_checker(11, 0 , 20)).to eql(11)
    end
  end
end