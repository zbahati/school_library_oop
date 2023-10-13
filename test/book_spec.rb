# book_spec.rb
require 'rspec'
require_relative '../library_manager'

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
end
