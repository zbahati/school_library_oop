# menu.rb
require_relative 'library_manager'
require_relative 'input_validator'
require_relative 'menu_data/list_all_books'

class Menu
  def initialize(library_manager)
    @library_manager = library_manager
    @list_all_books_options = ListAllBooks.new(library_manager)
  end

  def display_menu
    puts "\nLibrary Management System"
    MENU_OPTIONS.each do |key, value|
      puts "#{key}. #{value[:label]}"
    end
    print 'Enter your choice: '
  end

  MENU_OPTIONS = {
    1 => { label: 'List all books', action: :list_all_books },
    2 => { label: 'List all people', action: :list_all_people },
    3 => { label: 'Create a teacher or student', action: :create_person },
    4 => { label: 'Create a book', action: :create_book },
    5 => { label: 'Create a rental', action: :create_rental },
    6 => { label: 'List rentals for a person', action: :list_rentals_for_person },
    7 => { label: 'Quit', action: :quit }
  }.freeze

  def handle_choice(choice)
    if MENU_OPTIONS.key?(choice)
      action = MENU_OPTIONS[choice][:action]
      send(action)
    else
      puts 'Invalid choice. Please choose a valid option.'
    end
  end

  def valid_choice?(choice)
    (1..7).include?(choice)
  end

  # list all books
  def list_all_books
    @list_all_books_options.list_all_books
  end

  # list all people
  def list_all_people
    puts 'List of All People:'
    @library_manager.people.each do |person|
      puts "#{person.name} (ID: #{person.id})"
    end
  end

  # list all Teacher

  def create_person
    puts 'Create a Person:'
    puts '1. Create a Teacher'
    puts '2. Create a Student'
    choice = gets.chomp.to_i

    case choice
    when 1
      create_teacher
    when 2
      create_student
    else
      puts 'Invalid choice.'
    end
  end

  def create_teacher
    puts 'Enter teacher\'s name:'
    name = gets.chomp
    puts 'Enter teacher\'s age:'
    age = gets.chomp.to_i

    if age >= 18
      puts "Enter teacher's specialization:"
      specialization = gets.chomp

      teacher = @library_manager.create_person(age, name, specialization)
      puts "Teacher #{teacher.name} (ID: #{teacher.id}) created successfully."
    else
      puts 'You must be 18 or older to create a teacher.'
    end
  end

  def create_student
    puts 'Enter student\'s name:'
    name = gets.chomp
    puts 'Enter student\'s age:'
    age = gets.chomp.to_i

    if age >= 13
      puts 'Do you have parent permission? (yes/no)'
      permission = gets.chomp.downcase == 'yes'

      if permission
        student = @library_manager.create_person(age, name)
        puts "Student #{student.name} (ID: #{student.id}) created successfully."
      else
        puts 'Permission denied. You must have parent permission to create a student.'
      end
    else
      puts 'You must be 13 or older to create a student.'
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
        create_rental_for_person(person)
      else
        puts "Person with ID #{person_id} not found."
      end
    else
      puts 'Invalid person ID. Please enter a valid ID.'
    end
  end

  def create_rental_for_person(person)
    puts 'Enter book title to be rented:'
    book_title = gets.chomp
    book = @library_manager.books.find { |b| b.title == book_title }

    if book
      puts 'Enter rental date (YYYY-MM-DD):'
      date = gets.chomp

      if InputValidator.validate_date_input(date)
        @library_manager.create_rental(date, book, person)
        puts 'Rental recorded successfully.'
      else
        puts 'Invalid date format. Please use YYYY-MM-DD format.'
      end
    else
      puts "Book '#{book_title}' not found."
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
    exit
  end
end
