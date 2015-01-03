require 'set'
require 'values'

class World
  private_class_method :new

  def self.empty
    new
  end

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

  def apply_rules(alive_rules, dead_rules)
    apply_alive_rules(alive_rules)
    apply_dead_rules(dead_rules)
    self
  end

  private

  def apply_alive_rules(rules)
    @live_cells.each do |coordinate|
      rules.apply(coordinate, alive_neighbour_count(coordinate))
    end
  end

  def apply_dead_rules(rules)
    fringe.each do |coordinate|
      rules.apply(coordinate, alive_neighbour_count(coordinate))
    end
  end

  def points_surrounding(coordinate)
    neighbourhood = (-1..1).flat_map do |delta_x|
      (-1..1).map do |delta_y|
        Coordinate2D.new(coordinate.x + delta_x, coordinate.y + delta_y)
      end
    end
    neighbourhood.reject { |c| c == coordinate }.to_set
  end

  def fringe
    @live_cells.inject(Set.new) do |fringe_cells, coordinate|
      fringe_cells + points_surrounding(coordinate)
    end - @live_cells
  end

  def alive_neighbour_count(coordinate)
    points_surrounding(coordinate).count { |point| @live_cells.include? point }
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

class Coordinate2D < Value.new(:x, :y)
end

class UserInterface2D
  def initialize(width, height)
    @width = width
    @height = height
    @world = blank_world
  end

  def draw_cell(coordinate)
    @world[coordinate.y][coordinate.x] = 1
  end

  def print_world
    @world.each do |row|
      row.each do |column|
        print column
      end
      puts
    end
    puts
  end

  private

  def blank_world
    Array.new(@height) { Array.new(@width, 0) }
  end
end
