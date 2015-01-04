class GenericRule
  def initialize(world)
    @world = world
    self
  end

  def apply(coordinate, alive_neighbours)
    @world.come_alive_at(coordinate) if come_to_life?(coordinate, alive_neighbours)
  end 

  protected

  def come_to_life?(coordinate, alive_neighbours)
    true
  end
end
