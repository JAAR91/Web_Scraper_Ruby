# spec..lib/input_checker.rb
require './lib/input_checker'

describe Inputchecker do
  let(:input) { Inputchecker.new }
  describe '#search_result_check' do
    it 'checks the input entered and verify its betwen 1 and the parameter entered' do
      expect(input.search_result_check('5', 10)).to eql('5')
    end

    it 'checks the input entered and verify its betwen 1 and the parameter entered' do
      expect(input.search_result_check('7', 10)).not_to eql('5')
    end
  end

  describe '#empty_checker' do
    it 'checks if the imput enteres is a empty string or nil' do
      expect(input.empty_checker('Hello World')).to eql('Hello World')
    end

    it 'checks if the imput enteres is a empty string or nil' do
      expect(input.empty_checker('I do not know other negative test')).not_to eql('Hello World')
    end
  end

  describe '#menu_list_checker' do
    it 'checks the input entered its inside the numbers requested' do
      expect(input.menu_list_checker('m', 0, %w[b n m])).to eql('m')
    end

    it 'checks the input entered its inside the numbers requested' do
      expect(input.menu_list_checker('m', 0, %w[b n m])).not_to eql('n')
    end

    it 'checks the input entered if its n and return the next page number' do
      expect(input.menu_list_checker('n', 0, %w[b n m])).to eql('n')
    end

    it 'checks the input entered if its n and return the next page number' do
      expect(input.menu_list_checker('n', 60, %w[b n m])).not_to eql('51')
    end

    it 'checks the input entered if its b and return the previous page number' do
      expect(input.menu_list_checker('b', 0, %w[b n m])).to eql('b')
    end

    it 'checks the input entered if its b and return the previous page number' do
      expect(input.menu_list_checker('b', 0, %w[b n m])).not_to eql(-20)
    end

    it 'checks the input entered if its a number betwen the numbers requested' do
      expect(input.menu_list_checker('56', 2, %w[b n m])).to eql('56')
    end

    it 'checks the input entered if its a number betwen the numbers requested' do
      expect(input.menu_list_checker('56', 2, %w[b n m])).not_to eql('66')
    end
  end

  describe '#number_checker' do
    it 'checks the input entered its a number betwen the numbers requested' do
      expect(input.number_checker(11, 0, 20)).to eql(11)
    end

    it 'checks the input entered its a number betwen the numbers requested' do
      expect(input.number_checker(11, 0, 20)).not_to eql(21)
    end
  end

  describe '#empty_checker' do
    it 'makes sure input is never empty and the returns the input entered' do
      expect(input.empty_checker('hi')).to eql('hi')
    end

    it 'makes sure input is never empty and the returns the input entered' do
      expect(input.empty_checker('hi')).not_to eql('')
    end
  end

  describe '#checking_array' do
    it 'return an array of numbers as strings and letters b n or m' do
      expect(input.checking_array(1, %w[n b m])).to eql(%w[n b m  21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38
                                                 39 40 ])
    end

    it 'return an array of numbers as strings and letters b n or m' do
      expect(input.checking_array(21, %w[n b m])).not_to eql(%w[B N b n m M 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37
                                                     38 39])
    end
  end
end
