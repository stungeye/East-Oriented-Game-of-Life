class Coordinate2D
  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    other.same_xy?(@x, @y)
  end

  def same_xy?(x, y)
    @x == x && @y == y
  end

  def self.random(bounds = 10)
    new(rand(bounds), rand(bounds))
  end

  def neighbour?(other)
    other.neighbour_xy?(@x, @y)
  end

  def neighbour_xy?(x, y)
    # Remember, you are not your own neighbour!
    return false  if same_xy?(x, y)
    # A neighbour is an adjecent cell. In otherwords, neither our delta x or our
    # delta y can be greater than one.
    (@x - x).abs <= 1 && (@y - y).abs <= 1
  end
end
