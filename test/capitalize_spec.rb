# capitalize_spec.rb
require_relative '../capitalize_class'
require_relative '../decorator_class'
require 'rspec'

# Mock Nameable class for testing
class MockNameable
  attr_reader :correct_name

  def initialize(name)
    @correct_name = name
  end
end

RSpec.describe CapitalizeDecorator do
  before(:each) do
    @nameable = MockNameable.new('testname')
    @decorated_nameable = CapitalizeDecorator.new(@nameable)
  end

  describe '#correct_name' do
    it 'capitalizes the name' do
      expect(@decorated_nameable.correct_name).to eq('Testname')
    end
  end
end
