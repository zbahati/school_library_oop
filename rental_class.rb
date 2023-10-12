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
      book: @book.to_json,
      person: @person.to_json
    }.to_json
  end

  def self.from_json(data, book, person)
    date = data['date']

    Rental.new(date, book, person)
  end

  def self.save_all_to_json(rentals, file_name)
    data = rentals.map do |rental|
      {
        date: rental.date,
        book: rental.book.to_json,
        person: rental.person.to_json
      }
    end

    File.write(file_name, JSON.generate(data))
  end

  def self.load_all_from_json(file_name, books, people)
    if File.exist?(file_name)
      rental_data = JSON.parse(File.read(file_name))
      rental_data.map do |data|
        date = data['date']
        book_data = data['book']
        person_data = data['person']

        book = Book.from_json(book_data)
        person = Person.from_json(person_data)

        Rental.new(date, book, person)
      end
    else
      puts "Rental data file #{file_name} not found."
      []
    end
  end
end
