require 'set'

class World
  def self.empty
    new
  end

  def empty?(if_empty)
    if_empty.call  if @locations.size.zero?
    self
  end

  def add_location(location)
    @locations << location
    self
  end

  def tick
    self
  end

  private

  def initialize
    @locations = Set.new
  end
end
