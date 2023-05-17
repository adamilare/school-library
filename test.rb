require_relative 'person'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'student'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'

person = Person.new(22, 'maximilianus')
person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
capitalized_trimmed_person.correct_name

book1 = Book.new('Introduction to Ruby', 'Karim')
book2 = Book.new('Ruby Demystified', 'Dare')

classroom = Classroom.new('Module 4')

student1 = Student.new(22, name: 'Dare')
student2 = Student.new(19, name: 'Precious')
student1.add_rental('2023-3-17', book1)
student1.add_rental('2023-4-1', book2)

p(student1.rentals.map { |rental| rental.book.title })

classroom.add_student(student1)
classroom.add_student(student2)
p classroom.students.map(&:name)
