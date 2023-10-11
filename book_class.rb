class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  # Saved book data to json file
  def to_json(*_args)
    {
      title: @title,
      author: @author,
      rentals: @rentals.map(&:to_json)
    }
  end

  # Read data from json
  def self.from_json(data)
    book = Book.new(data['title'], data['author'])
    data['rentals'].each do |rental_data|
      rental = Rental.from_json(rental_data)
      book.add_rental(rental)
    end
    book
  end
end
