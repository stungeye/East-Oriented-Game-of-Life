class Coordinate1D < Value.new(:x)
  def neighbouring_coordinates
    [Coordinate1D.new(self.x - 1), Coordinate1D.new(self.x + 1)]
  end
end
