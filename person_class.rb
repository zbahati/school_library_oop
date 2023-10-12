require_relative 'nameable_class'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @parent_permission = parent_permission
    @id = Random.rand(1..1000)
    @name = name
    @age = age
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(book, date)
    rental = Rental.new(date, book, self)
    book.add_rental(rental)
  end

  def to_json(*_args)
    {
      age: @age,
      name: @name,
      parent_permission: @parent_permission,
      id: @id
    }
  end

  def self.from_json(data)
    age = data['age']
    name = data['name']
    parent_permission = data['parent_permission']
    id = data['id']

    # Create and return a new Person object with the extracted data
    person = Person.new(age, name, parent_permission: parent_permission)
    person.instance_variable_set(:@id, id)
    person.instance_variable_set(:@name, name)
    person
  end

  private

  def of_age?
    @age >= 18
  end
end
