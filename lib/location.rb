class Location
  def initialize(coordinate)
    @coordinate = coordinate
  end

  def same_position?(other)
    other.same_coordinate?(@coordinate)
  end

  def same_coordinate?(other_coordinate)
    @coordinate == other_coordinate
  end
end
