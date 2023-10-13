require 'rspec'
require_relative '../classroom_class'
require_relative '../library_manager'
require_relative '../person_class'
require_relative '../book_class'
require_relative '../student_class'
require_relative '../rental_class'

describe Classroom do
  let(:classroom) { Classroom.new('Class A') }

  describe '#initialize' do
    it 'creates a classroom with the given label' do
      expect(classroom.label).to eq('Class A')
      expect(classroom.students).to be_empty
    end
  end

  it 'can add a student to the classroom' do
    classroom = Classroom.new('Class A')
    student = Student.new('John')

    classroom.add_student(student)

    expect(classroom.students).to include(student)
    expect(student.classroom).to eq(classroom)
  end
end
