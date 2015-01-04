class Rule90 < GenericRule
  protected

  def come_to_life?(coordinate, alive_neighbours)
    alive_neighbours.count == 1
  end
end

class Rule30Alive < GenericRule
  protected

  def come_to_life?(coordinate, alive_neighbours)
    number_of_neighbours = alive_neighbours.count
    right_neighbour = Coordinate1D.new(coordinate.x + 1)
    number_of_neighbours.zero? ||
      (number_of_neighbours == 1 && alive_neighbours.first == right_neighbour)
  end
end

class Rule30Dead < GenericRule
  protected

  def come_to_life?(coordinate, alive_neighbours)
    alive_neighbours.count == 1
  end
end
