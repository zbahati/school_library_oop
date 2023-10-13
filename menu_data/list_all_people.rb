class ListAllPeople
  def initialize(library_manager)
    @library_manager = library_manager
  end

  def list_all_people
    puts 'List of All People:'
    if @library_manager.people.empty?
      puts 'Not found'
    else
      @library_manager.people.each do |person|
        puts "#{person.name} (ID: #{person.id})"
      end
    end
  end
end
