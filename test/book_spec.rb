# book_spec.rb
require 'rspec'
require_relative '../library_manager'
require_relative '../person_class'
require_relative '../book_class'
require_relative '../rental_class'

describe LibraryManager do
  let(:library_manager) { LibraryManager.new }

  describe '#create_book' do
    it 'adds a book to the library without rentals' do
      book = library_manager.create_book('Patient & Good luck', 'Brymo')
      expect(book.title).to eq('Patient & Good luck')
      expect(book.author).to eq('Brymo')
      expect(book.rentals).to be_empty
    end
  end

  it 'can add a rental to the book' do
    book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')
    date = '2023-10-12'
    person = Person.new(25, 'John', parent_permission: true)

    rental = Rental.new(date, book, person)
    book.add_rental(rental)

    expect(book.rentals.count).to eq(1)
    added_rental = book.rentals.first
    expect(added_rental).to eq(rental)
  end
end
