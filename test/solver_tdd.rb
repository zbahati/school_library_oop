require 'rspec'
require_relative '../solver_class'
describe Solver do

  describe '#factorial' do
    it 'returns 1 when given 0' do
      expect(factorial.new.factorial(0).to eq(1))
    end
  end
end