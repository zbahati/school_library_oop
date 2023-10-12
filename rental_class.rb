class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
  end

  def to_json(*_args)
    {
      date: @date,
      book: @book.title,
      person: @person.id
    }
  end

  def self.from_json(data, books, people)
    date = data['date']
    book_data = data['book']
    person_data = data['person']
    book = books.find { |b| b.title == book_data }
    person = people.find { |p| p.id == person_data }

    Rental.new(date, book, person)
  end
end
