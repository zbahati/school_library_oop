require_relative '../trim_class'
require_relative '../nameable_class'
require 'rspec'

# Mock Nameable class for testing
class MockNameable
  attr_reader :correct_name

  def initialize(name)
    @correct_name = name
  end
end

RSpec.describe TrimmerDecorator do
  before(:each) do
    @nameable = MockNameable.new('TestName12345')
    @decorated_nameable = TrimmerDecorator.new(@nameable)
  end

  describe '#correct_name' do
    it 'trims the name to a maximum of 10 characters' do
      expect(@decorated_nameable.correct_name).to eq('TestName12')
    end

    it 'does not trim the name if it is 10 characters or less' do
      nameable = MockNameable.new('ShortName')
      decorated_nameable = TrimmerDecorator.new(nameable)
      expect(decorated_nameable.correct_name).to eq('ShortName')
    end
  end
end
