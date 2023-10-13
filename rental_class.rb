class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
  end

  # Method to convert a Rental object to a JSON representation
  def to_json(*_args)
    {
      date: @date,
      book: @book.title,
      person: @person.id
    }
  end

  # Method to create a Rental object from JSON data
  def self.from_json(data, books, people)
    date = data['date']
    book_title = data['book']
    person_id = data['person']

    book = books.find { |b| b.title == book_title }
    person = people.find { |p| p.id == person_id }

    Rental.new(date, book, person)
  end
end
