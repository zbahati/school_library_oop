require 'json'
require_relative 'person_class'
require_relative 'book_class'
require_relative 'rental_class'

class LibraryManager
  attr_reader :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
    load_data_from_json
  end

  def create_person(age, name, specialization = nil)
    person = specialization ? Teacher.new(specialization, age, name) : Student.new(age, name)
    @people << person
    save_data_to_json
    person
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    save_data_to_json
    book
  end

  def create_rental(date, book, person)
    rental = Rental.new(date, book, person)
    @rentals << rental
    save_data_to_json
    rental
  end

  def save_data_to_json
    data = {
      people: @people.map(&:to_json),
      books: @books.map(&:to_json),
      rentals: @rentals.map(&:to_json)
    }

    # Save data into separate JSON files
    File.write('people.json', data[:people].to_json)
    File.write('books.json', data[:books].to_json)
    File.write('rentals.json', data[:rentals].to_json)
  end

  def load_data_from_json
    load_people_from_json if File.exist?('people.json')
    load_books_from_json if File.exist?('books.json')
    load_rentals_from_json if File.exist?('rentals.json')
  end

  def load_people_from_json
    people_data = JSON.parse(File.read('people.json'))
    @people = people_data.map { |person_data| Person.from_json(person_data) }
  end

  def load_books_from_json
    books_data = JSON.parse(File.read('books.json'))
    @books = books_data.map { |book_data| Book.from_json(book_data) }
  end

  def load_rentals_from_json
    rentals_data = JSON.parse(File.read('rentals.json'))
    @rentals = rentals_data.map { |rental_data| Rental.from_json(rental_data, @books, @people) }
  end
end
