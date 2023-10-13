class DataManager
  # Saved data to json file
  def self.save_to_json(filename, data)
    File.write(filename, data.to_json)
  end

  # Read data from json file
  def self.load_from_json(filename)
    if File.exist?(filename)
      JSON.parse(File.read(filename))
    else
      []
    end
  end

  # Save books to a JSON file
  def self.save_books(books)
    save_to_json('books.json', books)
  end

  # Load books from a JSON file
  def self.load_books
    load_from_json('books.json')
  end
end
