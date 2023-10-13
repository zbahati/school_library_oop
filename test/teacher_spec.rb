require 'rspec'
require_relative '../library_manager'
require_relative '../teacher_class'

describe LibraryManager do
  let(:library_manager) { LibraryManager.new }

  describe '#create_person' do
    it 'adds a teacher to the library' do
      teacher = library_manager.create_person(35, 'Mr. Smith', 'Math')
      expect(teacher).to be_a(Teacher)
      expect(teacher.age).to eq(35)
      expect(teacher.name).to eq('Mr. Smith')
    end
  end
end
