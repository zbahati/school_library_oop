require 'rspec'
require_relative '../rental_class'
require_relative '../book_class'
require_relative '../person_class'

describe Rental do
  let(:book) { Book.new('The Great Gatsby', 'F. Scott Fitzgerald') }
  let(:person) { Person.new(30, 'John Doe') }
  let(:date) { '2023-10-12' }
  let(:rental) { Rental.new(date, book, person) }

  it 'has a date' do
    expect(rental.date).to eq('2023-10-12')
  end

  it 'has a book' do
    expect(rental.book).to eq(book)
  end

  it 'has a person' do
    expect(rental.person).to eq(person)
  end

  it 'generates JSON representation' do
    json_data = rental.to_json
    expect(json_data).to be_a(Hash)
    expect(json_data[:date]).to eq('2023-10-12')
    expect(json_data[:book]).to eq('The Great Gatsby')
    expect(json_data[:person]).to eq(person.id)
  end

end
