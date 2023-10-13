require 'rspec'
require_relative '../student_class'

describe Student do
  let(:student) { Student.new(16, 'John Doe') }
  let(:classroom) { double('Classroom', add_student: true) }

  describe '#add_to_classroom' do
    context 'when not already in a classroom' do
      it 'adds the student to a classroom' do
        student.add_to_classroom(classroom)
        expect(student.classroom).to eq(classroom)
      end

      it 'calls add_student on the classroom' do
        expect(classroom).to receive(:add_student).with(student)
        student.add_to_classroom(classroom)
      end
    end

    context 'when already in a classroom' do
      it 'does not add the student to another classroom' do
        student.add_to_classroom(classroom)
        new_classroom = double('Another Classroom', add_student: true)
        student.add_to_classroom(new_classroom)
        expect(student.classroom).to eq(classroom)
      end

      it 'prints a message indicating the student is already in a classroom' do
        student.add_to_classroom(classroom)
        new_classroom = double('Another Classroom', add_student: true)
        expect { student.add_to_classroom(new_classroom) }.to output(/is already in a classroom/).to_stdout
      end
    end
  end

  describe '#play_hooky' do
    it 'returns a string with the shrugging emoticon' do
      expect(student.play_hooky).to eq('¯\\(ツ)/¯')
    end
  end
end
