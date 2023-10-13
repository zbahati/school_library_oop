class ListAllRentals
  def initialize(library_manager)
    @library_manager = library_manager
  end

  def list_all_rentals
    puts 'List of All Rentals:'
    if @library_manager.rentals.nil? || @library_manager.rentals.empty?
      puts 'No rentals found'
    else
      @library_manager.rentals.each do |rental|
        rental_info = "#{rental.date}: #{rental.book.title} Rent by: #{rental.person.name} (ID: #{rental.person.id})"
        puts rental_info
      end
    end
  end
end
