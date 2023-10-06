require_relative 'person_class'
require_relative 'student_class'
require_relative 'teacher_class'
require_relative 'classroom_class'
require_relative 'book_class'
require_relative 'rental_class'

class LibraryApp
  def initialize
    @people = []
    @books = []
    @classrooms = []
    @rentals = []
  end

  def list_all_books
    puts 'List of All Books:'
    @books.each do |book|
      puts "#{book.title} by #{book.author}"
    end
  end

  def list_all_people
    puts 'List of All People:'
    @people.each do |person|
      puts "#{person.name} (ID: #{person.id})"
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
    puts "Enter teacher's name:"
    name = gets.chomp
    puts "Enter teacher's age:"
    age = gets.chomp.to_i
    puts "Enter teacher's specialization:"
    specialization = gets.chomp

    teacher = Teacher.new(specialization, age, name)
    @people << teacher
    puts "Teacher #{teacher.name} (ID: #{teacher.id}) created successfully."
  end

  def create_student
    puts 'Enter student\'s name:'
    name = gets.chomp
    puts 'Enter student\'s age:'
    age = gets.chomp.to_i

    student = Student.new(age, name)
    @people << student
    puts "Student #{student.name} (ID: #{student.id}) created successfully."
  end

  def create_book
    puts 'Enter book title:'
    title = gets.chomp
    puts 'Enter book author:'
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts "Book '#{book.title}' by #{book.author} created successfully."
  end

  def create_rental
    puts 'Enter person\'s ID (teacher or student) who is renting the book: '
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts "Person with ID #{person_id} not found."
      return
    end

    puts 'Enter book title to be rented:'
    book_title = gets.chomp
    book = @books.find { |b| b.title == book_title }

    if book.nil?
      puts "Book '#{book_title}' not found."
      return
    end

    puts 'Enter rental date (YYYY-MM-DD):'
    date = gets.chomp

    rental = Rental.new(date, book, person)
    @rentals << rental
    puts 'Rental recorded successfully.'
  end

  def list_rentals_for_person
    puts 'Enter person\'s ID to list their rentals:'
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts "Person with ID #{person_id} not found."
      return
    end

    puts "Rentals for #{person.name} (ID: #{person.id}):"
    rentals = @rentals.select { |r| r.person == person }
    rentals.each do |rental|
      puts "#{rental.date}: #{rental.book.title} by #{rental.book.author}"
    end
  end

  MENU_OPTIONS = {
    1 => :list_all_books,
    2 => :list_all_people,
    3 => :create_person,
    4 => :create_book,
    5 => :create_rental,
    6 => :list_rentals_for_person,
    7 => :quit
  }.freeze

  def run
    loop do
      display_menu
      choice = gets.chomp.to_i

      if MENU_OPTIONS.key?(choice)
        send(MENU_OPTIONS[choice])
      else
        invalid_choice
      end

      break if choice == 7
    end
  end

  def display_menu
    puts "\nLibrary Management System"
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Quit'
    print 'Enter your choice: '
  end

  def invalid_choice
    puts 'Invalid choice. Please choose a valid option.'
  end
end

app = LibraryApp.new
app.run
