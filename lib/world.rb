require 'set'

class World
  def self.empty
    new
  end

  def empty?(if_empty)
    if_empty.call  if @cells.size.zero?
    self
  end

  def alive_at(location)
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
