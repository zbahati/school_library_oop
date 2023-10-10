require_relative 'library_manager'
require_relative 'input_validator'

class Menu
  def initialize(library_manager)
    @library_manager = library_manager
  end

  def display_menu
    puts "\nLibrary Management System"
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a teacher'
    puts '4. Create a student'
    puts '5. Create a book'
    puts '6. Create a rental'
    puts '7. List rentals for a person'
    puts '8. Quit'
    print 'Enter your choice: '
  end

  def valid_choice?(choice)
    (1..8).include?(choice)
  end

  def handle_choice(choice)
    case choice
    when 1 then list_all_books
    when 2 then list_all_people
    when 3 then create_teacher
    when 4 then create_student
    when 5 then create_book
    when 6 then create_rental
    when 7 then list_rentals_for_person
    when 8 then quit
    else
      puts 'Invalid choice. Please choose a valid option.'
    end
  end

  def list_all_books
    puts 'List of All Books:'
    @library_manager.books.each do |book|
      puts "#{book.title} by #{book.author}"
    end
  end

  def list_all_people
    puts 'List of All People:'
    @library_manager.people.each do |person|
      puts "#{person.name} (ID: #{person.id})"
    end
  end

  def create_teacher
    puts "Enter teacher's name:"
    name = gets.chomp
    puts "Enter teacher's age:"
    age = gets.chomp
    puts "Enter teacher's specialization:"
    specialization = gets.chomp

    if InputValidator.validate_integer_input(age)
      teacher = @library_manager.create_person(age.to_i, name, specialization)
      puts "Teacher #{teacher.name} (ID: #{teacher.id}) created successfully."
    else
      puts 'Invalid age. Please enter a valid age.'
    end
  end

  def create_student
    puts 'Enter student\'s name:'
    name = gets.chomp
    puts 'Enter student\'s age:'
    age = gets.chomp

    if InputValidator.validate_integer_input(age)
      student = @library_manager.create_person(age.to_i, name)
      puts "Student #{student.name} (ID: #{student.id}) created successfully."
    else
      puts 'Invalid age. Please enter a valid age.'
    end
  end

  def create_book
    puts 'Enter book title:'
    title = gets.chomp
    puts 'Enter book author:'
    author = gets.chomp

    book = @library_manager.create_book(title, author)
    puts "Book '#{book.title}' by #{book.author} created successfully."
  end

  def create_rental
    puts 'Enter person\'s ID (teacher or student) who is renting the book: '
    person_id = gets.chomp

    if InputValidator.validate_integer_input(person_id)
      person_id = person_id.to_i
      person = @library_manager.people.find { |p| p.id == person_id }

      if person
        puts 'Enter book title to be rented:'
        book_title = gets.chomp
        book = @library_manager.books.find { |b| b.title == book_title }

        if book
          puts 'Enter rental date (YYYY-MM-DD):'
          date = gets.chomp

          if InputValidator.validate_date_input(date)
            rental = @library_manager.create_rental(date, book, person)
            puts 'Rental recorded successfully.'
          else
            puts 'Invalid date format. Please use YYYY-MM-DD format.'
          end
        else
          puts "Book '#{book_title}' not found."
        end
      else
        puts "Person with ID #{person_id} not found."
      end
    else
      puts 'Invalid person ID. Please enter a valid ID.'
    end
  end

  def list_rentals_for_person
    puts 'Enter person\'s ID to list their rentals:'
    person_id = gets.chomp

    if InputValidator.validate_integer_input(person_id)
      person_id = person_id.to_i
      person = @library_manager.people.find { |p| p.id == person_id }

      if person
        puts "Rentals for #{person.name} (ID: #{person.id}):"
        rentals = @library_manager.rentals.select { |r| r.person == person }
        rentals.each do |rental|
          puts "#{rental.date}: #{rental.book.title} by #{rental.book.author}"
        end
      else
        puts "Person with ID #{person_id} not found."
      end
    else
      puts 'Invalid person ID. Please enter a valid ID.'
    end
  end

  def quit
    puts 'Exiting the Library Management System. Goodbye!'
  end
end