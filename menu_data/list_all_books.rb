class ListAllBooks
  def initialize(library_manager)
    @library_manager = library_manager
  end

  def list_all_books
    puts 'List of All Books:'
    if @library_manager.books.empty?
      puts 'No books found'
    else
      @library_manager.books.each do |book|
        puts "#{book.title} by #{book.author}"
      end
    end
  end
end
