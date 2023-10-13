require 'rspec'
require_relative '../solver_class'
describe Solver do

  describe '#factorial' do
    it 'Raises exception  when given any negative number' do
      expect{Solver.new.factorial(-1)}.to raise_error(ArgumentError)
    end
    it 'returns 1 when given 0' do
      expect(Solver.new.factorial(0)).to eq(1)
    end

    it 'returns the factorial of the positive integers' do
      expect(Solver.new.factorial(4)).to eq(24)
      expect(Solver.new.factorial(3)).to eq(6)
    end
  end

  describe '#reverse' do
    it 'return the reverse of the word given' do
      expect(Solver.new.reverse('hello')).to eq('olleh')
    end
  end

  describe "#fuzzbuzz" do
    it 'returns fuzz when given number is divided by 3' do
      expect(Solver.new.fuzzbuzz(3)).to eq('fuzz')
    end
  end

end