class World
  def empty?(if_empty)
    if_empty.()
    self
  end

  def tick
    self
  end
end
