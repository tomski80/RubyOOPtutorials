
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
end


bob = Person.new('Robert Smith')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'
