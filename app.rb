require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'book'
require_relative 'rental'

class App
  attr_accessor :books, :persons, :rentals

  def initialize
    @books = []
    @persons = []
    @rentals = []
  end

  def line_return
    puts '--------------------------------------------'
  end

  # books ------

  def print_books
    puts "All #{@books.length} books added are;"
    @books.each do |book|
      puts " - Title: #{book.title},  Author: #{book.author}"
    end
  end

  def print_books_by_index
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "  #{index}) Title: #{book.title},  Author: #{book.author}"
    end
  end

  def list_books
    @books.length.positive? ? print_books : (puts 'No books available')
    line_return
  end

  def add_book
    puts 'What is the title of the book?'
    title = gets.chomp
    puts 'Who is the author of the book?'
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book successfully created'
    line_return
  end

  # persons ------

  def print_persons_by_index
    @persons.each_with_index do |person, index|
      puts "#{index}) [#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def print_persons
    puts "All #{@persons.length} created persons are;"
    @persons.each do |person|
      puts " [#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def list_people
    @persons.length.positive? ? print_persons : (puts 'No person available')
    line_return
  end

  def add_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.capitalize
    print 'Has parent permission? (Y/N): '
    parent_permission = gets.chomp.downcase
    while parent_permission != 'y' && parent_permission != 'n'
      print 'Please input Y or N: '
      parent_permission = gets.chomp.downcase
    end

    @persons << Student.new(age, name: name, parent_permission: parent_permission == 'y')
    puts 'Student successfully created'
    line_return
  end

  def add_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.capitalize
    print 'Specialization: '
    specialization = gets.chomp.capitalize
    @persons << Teacher.new(specialization, age, name: name)
    puts 'Teacher successfully created'
    line_return
  end

  def add_person
    print 'Do you want to create a student (1) or a teacher (2)? [input the number]: '
    person_type = gets.chomp
    while person_type != '1' && person_type != '2'
      print 'Please input 1 or 2: '
      person_type = gets.chomp
    end
    person_type == '1' ? add_student : add_teacher
  end

  def select_book_to_rent
    print_books_by_index
    book_index = gets.chomp.to_i
    while book_index.negative? || book_index >= @books.length
      puts 'Please input a valid index'
      book_index = gets.chomp.to_i
    end
    puts 'book selected'
    @books[book_index]
  end

  def select_person_to_rent
    puts 'Select a person from the following list by number (not id)'
    print_persons_by_index
    person_index = gets.chomp.to_i
    while person_index.negative? || person_index >= @persons.length
      puts 'Please input a valid index'
      person_index = gets.chomp.to_i
    end
    puts 'person selected'
    @persons[person_index]
  end

  def list_renters
    @persons.each do |person|
      puts "  ID: #{person.id} [#{person.type}] Name: #{person.name}"
    end
  end

  def find_person(person_id)
    @persons.find { |p| p.id == person_id }
  end

  # rentals ---------

  def add_rental
    if @books.empty?
      puts 'There are no books available'
      line_return
      return
    end
    if @persons.empty?
      puts 'There are no persons available'
      line_return
      return
    end

    book = select_book_to_rent
    person = select_person_to_rent
    print 'Date (YYYY\MM\DD): '
    date = gets.chomp
    @rentals << Rental.new(date, person, book)
    puts 'Rental created successfully'
    line_return
  end

  def list_rentals
    puts 'Select id of the person from the following: '
    list_renters
    person_id = gets.chomp.to_i + 1
    person = find_person(person_id)
    while person.nil?
      puts 'Person do not exist, please enter a valid id'
      person_id = gets.chomp.to_i
      person = find_person(person_id)
    end

    puts "Rentals of #{person.name}:"
    person.rentals.each do |rental|
      puts "Date: #{rental.date} Book: #{rental.book.title} by #{rental.book.author}"
    end
    line_return
  end
end
