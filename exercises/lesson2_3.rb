
class Person

  attr_accessor :first_name, :last_name

  def initialize(fullname)
    parts = fullname.split
    @first_name = parts[0]
    @last_name = parts.size > 1 ? parts[1] : ''
  end

  def name
    self.first_name + ' ' + self.last_name
  end

  def name=(name)
    parts = name.split
    self.first_name = parts[0]
    self.last_name = parts.size > 1 ? parts[1] : ''
  end

end


bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name
puts "The person's name is: #{bob.name}"
puts "The person's name is: " + bob.name
