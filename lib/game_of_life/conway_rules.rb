class ConwayAliveRules
  def initialize(world)
    @world = world
    self
  end

  def apply(coordinate, alive_neighbours)
    number_of_neighbours = alive_neighbours.count
    @world.come_alive_at(coordinate) if (2..3).include?(number_of_neighbours)
    self
  end
end

class ConwayDeadRules
  def initialize(world)
    @world = world
    self
  end

  def apply(coordinate, alive_neighbours)
    number_of_neighbours = alive_neighbours.count
    @world.come_alive_at(coordinate) if number_of_neighbours == 3
    self
  end
end
