require_relative '../library_manager'
require_relative '../student_class'
require_relative '../book_class'
require_relative '../person_class'
require 'rspec'

describe LibraryManager do
  before(:each) do
    @library_manager = LibraryManager.new
  end

  it 'creates a book' do
    book = @library_manager.create_book('Title', 'Author')
    expect(book.title).to eq('Title')
    expect(book.author).to eq('Author')
  end

  it 'creates a person' do
    person = @library_manager.create_person(25, 'John Doe')
    expect(person.name).to eq('John Doe')
    expect(person.age).to eq(25)
  end

  it 'creates a rental' do
    # Create a book
    book = @library_manager.create_book('Book Title', 'Book Author')

    # Create a person (student)
    student = @library_manager.create_person(15, 'Student Name')

    # Create a rental
    rental_date = '2023-10-12'
    rental = @library_manager.create_rental(rental_date, book, student)

    # Validate the rental
    expect(rental.date).to eq(rental_date)
    expect(rental.book).to eq(book)
    expect(rental.person).to eq(student)
  end
end
