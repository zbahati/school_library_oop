class Book
  attr_accessor :title, :author, :rentals
  attr_reader :id

  def initialize(title, author)
    @id = Random.rand(1..1000)
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
      id: @id,
      title: @title,
      author: @author,
      rentals: @rentals.map(&:to_json)
    }
  end

  # Read data from json
  def self.from_json(data)
    id = data['id']
    title = data['title']
    author = data['author']
    rentals_data = data['rentals'] || []

    book = Book.new(title, author)
    book.instance_variable_set(:@id, id)

    rentals_data.each do |rental_data|
      rental = Rental.from_json(rental_data, book, nil) # Pass nil for person
      book.add_rental(rental)
    end

    book
  end
end
