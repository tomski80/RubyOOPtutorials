# class Car

class Car
  attr_reader :year , :model, :speed
  attr_accessor :color

  def initialize(year,color,carmodel)
    @year   = year
    @color  = color
    @model  = carmodel
    @speed  = 0
  end

  def speed_up(mph)
    @speed += mph
  end

  def break(mph)
    @speed -= mph
  end

  def current_speed
    self.speed
  end

  def shut_down
    self.speed = 0
  end

end

mycar = Car.new(2001,'green','astra')

mycar.speed_up(100)
puts mycar.current_speed
puts mycar.year
puts mycar.model
