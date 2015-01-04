require 'set'
require 'values'

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
      rules.apply(coordinate, alive_neighbour_count(coordinate))
    end
    self
  end

  def apply_dead_rules(rules)
    fringe.each do |coordinate|
      rules.apply(coordinate, alive_neighbour_count(coordinate))
    end
    self
  end

  private

  def fringe
    @live_cells.inject(Set.new) do |fringe_cells, coordinate|
      fringe_cells + coordinate.neighbouring_coordinates
    end - @live_cells
  end

  def alive_neighbour_count(coordinate)
    neighbours = coordinate.neighbouring_coordinates
    neighbours.count { |point| @live_cells.include? point }
  end
end

class Coordinate2D < Value.new(:x, :y)
  def neighbouring_coordinates
    neighbourhood = (-1..1).flat_map do |delta_x|
      (-1..1).map do |delta_y|
        Coordinate2D.new(self.x + delta_x, self.y + delta_y)
      end
    end
    neighbourhood.reject { |c| c == self }
  end
end

class ConwayAliveRules
  def initialize(world)
    @world = world
    self
  end

  def apply(coordinate, number_of_neighbours)
    @world.come_alive_at(coordinate) if (2..3).include?(number_of_neighbours)
    self
  end
end

class ConwayDeadRules
  def initialize(world)
    @world = world
    self
  end

  def apply(coordinate, number_of_neighbours)
    @world.come_alive_at(coordinate) if number_of_neighbours == 3
    self
  end
end

class UserInterface2D
  def initialize(width, height)
    @width = width
    @height = height
    @world = blank_world
    self
  end

  def draw_cell(coordinate)
    @world[coordinate.y][coordinate.x] = '#'
    self
  end

  def print_world
    @world.each do |row|
      row.each do |column|
        print column
      end
      puts
    end
    puts
    self
  end

  private

  def blank_world
    Array.new(@height) { Array.new(@width, '_') }
  end
end

world = World.empty
world_coords = [[1, 1], [1, 2], [1, 3], [5, 5], [5, 6], [6, 5], [6, 6]]
world_coords.each do |x, y|
  world.come_alive_at(Coordinate2D.new(x, y))
end

3.times do
  ui = UserInterface2D.new(10, 10)
  world.output(ui)
  ui.print_world
  new_world = World.empty
  world.apply_alive_rules(ConwayAliveRules.new(new_world))
  world.apply_dead_rules(ConwayDeadRules.new(new_world))
  world = new_world
end
