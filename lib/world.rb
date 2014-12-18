require 'set'

class World
  def self.empty
    new
  end

  def empty?(if_empty)
    if @cells.size.zero?
      if_empty.call
    end
    self
  end

  def set_living_at(location)
    @cells << location
    self
  end

  def tick
    self
  end

  private
  def initialize
    @cells = Set.new
  end
end
