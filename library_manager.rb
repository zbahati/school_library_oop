
require_relative 'person_class'
require_relative 'book_class'
require_relative 'rental_class'

class LibraryManager
  attr_reader :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def create_person(age, name, specialization = nil)
    person = specialization ? Teacher.new(specialization, age, name) : Student.new(age, name)
    @people << person
    person
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    book
  end

  def create_rental(date, book, person)
    rental = Rental.new(date, book, person)
    @rentals << rental
    rental
  end
end