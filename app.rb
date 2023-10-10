require_relative 'library_manager'
require_relative 'menu'
require_relative 'person_class'
require_relative 'student_class'
require_relative 'teacher_class'
require_relative 'classroom_class'
require_relative 'book_class'
require_relative 'rental_class'

library_manager = LibraryManager.new
menu = Menu.new(library_manager)

loop do
  menu.display_menu
  choice = gets.chomp.to_i

  if menu.valid_choice?(choice)
    menu.handle_choice(choice)
  else
    puts 'Invalid choice. Please choose a valid option.'
  end

  break if choice == 8
end