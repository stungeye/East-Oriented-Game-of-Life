class ConwayAliveRules < GenericRule
  protected

  def come_to_life?(coordinate, alive_neighbours)
    (2..3).include?(alive_neighbours.count)
  end
end

class ConwayDeadRules < GenericRule
  protected 

  def come_to_life?(coordinate, alive_neighbours)
    alive_neighbours.count == 3
  end
end
