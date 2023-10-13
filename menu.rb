# menu.rb
require_relative 'library_manager'
require_relative 'input_validator'
require_relative 'menu_data/list_all_books'
require_relative 'menu_data/list_all_people'
require_relative 'menu_data/list_all_rentals'

class Menu
  def initialize(library_manager)
    @library_manager = library_manager
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
    6 => { label: 'List all rentals', action: :list_all_rentals },
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

  def list_all_books
    puts 'List of all books:'
    @library_manager.books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    puts 'List of all people (teachers and students):'
    @library_manager.people.each do |person|
      puts "Name: #{person.name}, Age: #{person.age}, ID: #{person.id}"
      puts "Specialization: #{person.specialization}" if person.is_a?(Teacher)
    end
  end

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

  def list_all_rentals
    puts 'List of all rentals:'
    @library_manager.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title}, Person: #{rental.person.name}, ID: #{rental.person.id}"
    end
  end

  def quit
    puts 'Exiting the Library Management System. Goodbye!'
    exit
  end
end
