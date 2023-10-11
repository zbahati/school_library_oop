class Classroom
  attr_accessor :label, :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    if @students.include?(student)
      puts "#{student.name} is already in this classroom."
    else
      @students << student
      student.classroom = self
    end
  end
end
