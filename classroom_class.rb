class Classroom
  attr_accessor :lable
  def initialize(label)
    @label = label
    @Students = []
  end

  def add_student (student)
    @students << student
    student.classroom = self
  end

end