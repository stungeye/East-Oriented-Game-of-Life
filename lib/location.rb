class Location
  def initialize(x, y)
    @x = x
    @y = y
  end

  def same_position?(other_location, if_same_position)
    if_same_position.call
  end
end
