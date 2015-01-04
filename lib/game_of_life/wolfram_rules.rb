class Rule90Alive
  def initialize(world)
    @world = world
  end

  def apply(coordinate, number_of_neighbours)
    @world.come_alive_at(coordinate) if number_of_neighbours == 1
  end
end

class Rule90Dead
  def initialize(world)
    @world = world
  end

  def apply(coordinate, number_of_neighbours)
    @world.come_alive_at(coordinate) if number_of_neighbours == 1
  end
end
