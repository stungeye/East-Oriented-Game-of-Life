class World
  def self.empty
    new
  end

  def empty?(if_empty)
    if_empty.call  if @locations.size.zero?
    self
  end

  def add_location(new_location)
    @locations << new_location
    self
  end

  def tick
    self
  end

  private

  def initialize
    @locations = []
  end
end
