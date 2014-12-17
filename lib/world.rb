class World
  def self.empty
    new
  end

  def empty?(if_empty)
    if_empty.call
    self
  end

  def tick
    self
  end
end
