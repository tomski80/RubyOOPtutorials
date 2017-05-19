
class Person

  def initialize(name)
    @name = name
    @second_name = ''
  end

  def first_name
    name
  end

  def last_name
    @second_name
  end

  def last_name=(name)
    @second_name = name
  end

  def name
    @name + ' ' + @second_name
  end

end


bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'
