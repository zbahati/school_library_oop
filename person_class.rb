class Person
  attr_accessor :id, :name, :age

  def initialize(id, name = "Unknown", parent_permission = true)
    super()
    @id = Random.rand(1...10000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  private

  def of_age?
    @age >= 18
  end

  public

  def can_use_services?
    of_age? || @parent_permission
  end
end
