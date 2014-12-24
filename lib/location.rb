class Location
  def initialize(x, y)
    @x = x
    @y = y
  end

  def same_position?(other_location, if_same_position)
    other_location.same_coordinates?(@x, @y, if_same_position)
  end

  def same_coordinates?(x, y, if_same_coordinates)
    if_same_coordinates.call  if @x == x && @y == y
  end

  def self.random
    new(random(10), random(10))
  end
end
