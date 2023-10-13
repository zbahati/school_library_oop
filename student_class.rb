require './person_class'

class Student < Person
  attr_accessor :classroom

  def initialize(age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = nil
    @type = 'student'
  end

  def add_to_classroom(classroom)
    if @classroom.nil?
      @classroom = classroom
      classroom.add_student(self)
    else
      puts "#{@name} is already in a classroom."
    end
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
