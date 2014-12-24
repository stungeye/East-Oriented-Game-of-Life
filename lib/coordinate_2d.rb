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
end
