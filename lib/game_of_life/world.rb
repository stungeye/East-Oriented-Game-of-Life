class World
  def self.empty
    new
  end

  private_class_method :new

  def initialize
    @live_cells = Set.new
    self
  end

  def come_alive_at(coordinate)
    @live_cells << coordinate
    self
  end

  def output(ui)
    @live_cells.each do |coordinate|
      ui.draw_cell(coordinate)
    end
    self
  end

  def apply_alive_rules(rules)
    @live_cells.each do |coordinate|
      rules.apply(coordinate, alive_neighbours(coordinate))
    end
    self
  end

  def apply_dead_rules(rules)
    fringe.each do |coordinate|
      rules.apply(coordinate, alive_neighbours(coordinate))
    end
    self
  end

  private

  def fringe
    @live_cells.inject(Set.new) do |fringe_cells, coordinate|
      fringe_cells + coordinate.neighbouring_coordinates
    end - @live_cells
  end

  def alive_neighbours(coordinate)
    @live_cells.intersection(coordinate.neighbouring_coordinates)
  end
end
