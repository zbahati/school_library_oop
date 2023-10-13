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
end