require './person_class'

class Teacher < Person
  def initialize(specialization, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
    @type = 'teacher'
  end

  def can_use_services?
    true
  end
end
