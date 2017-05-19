class Pet
  def run
    'running'
  end

  def jump
    'jumping'
  end
end

class Dog < Pet
  def speal
    'bark'
  end

  def swim
    'swimming'
  end

  def fetch
    'fetching'
  end
end

class Cat < Pet
  def speak
    'miaow'
  end
end
