require_relative 'person'

class Teacher < Person
  attr_reader :specialization, :type

  def initialize(specialization, age, name: 'Unknown')
    super(age, name: name)
    @specialization = specialization
    @type = 'Teacher'
  end

  def can_use_services?
    true
  end
end
