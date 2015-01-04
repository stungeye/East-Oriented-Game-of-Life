class Rule90Alive
  def initialize(world)
    @world = world
  end

  def apply(coordinate, alive_neighbours)
    number_of_neighbours = alive_neighbours.count
    @world.come_alive_at(coordinate) if number_of_neighbours == 1
  end
end

class Rule90Dead
  def initialize(world)
    @world = world
  end

  def apply(coordinate, alive_neighbours)
    number_of_neighbours = alive_neighbours.count
    @world.come_alive_at(coordinate) if number_of_neighbours == 1
  end
end

class Rule30Alive
  def initialize(world)
    @world = world
  end

  def apply(coordinate, alive_neighbours)
    @world.come_alive_at(coordinate) if come_to_life?(coordinate, alive_neighbours)
  end

  private

  def come_to_life?(coordinate, alive_neighbours)
    number_of_neighbours = alive_neighbours.count
    right_neighbour = Coordinate1D.new(coordinate.x + 1)
    number_of_neighbours.zero? ||
      (number_of_neighbours == 1 && alive_neighbours.first == right_neighbour)
  end
end

class Rule30Dead
  def initialize(world)
    @world = world
  end

  def apply(coordinate, alive_neighbours)
    number_of_neighbours = alive_neighbours.count
    @world.come_alive_at(coordinate) if number_of_neighbours == 1
  end
end
