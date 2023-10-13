require 'rspec'
require_relative '../classroom_class'

describe Classroom do
  let(:classroom) { Classroom.new('Class A') }

  describe '#initialize' do
    it 'creates a classroom with the given label' do
      expect(classroom.label).to eq('Class A')
      expect(classroom.students).to be_empty
    end
  end
end
