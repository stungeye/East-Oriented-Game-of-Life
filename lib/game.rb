require 'forwardable'

class Game
  extend Forwardable

  def initialize(board)
    @board = board
    self
  end

  def_delegator :@board, :come_alive_at

  def next_generation(alive_rules, dead_rules)
    self
  end

  def output(ui)
    @board.each_live_cell do |x, y|
      ui.draw_cell(x, y)
    end
    self
  end
end

class Board
  private_class_method :new

  def self.empty
    new
  end

  def initialize
    @cells = Set.new
    self
  end

  def come_alive_at(x, y)
    @cells << [x, y]
    self
  end

  def each_live_cell
    @cells.each do |cell|
      yield cell
    end
    self
  end

  def each_fringe_cell
    fringe.each do |cell|
      yield cell
    end
    self
  end

  def apply_alive_rules(rules)
    each_live_cell do |x, y|
      rules.apply(x, y, alive_neighbour_count(x, y))
    end
  end

  private

  def points_surrounding(x, y)
    [[x, y - 1],
     [x - 1, y],
     [x + 1, y],
     [x, y + 1]].to_set
  end

  def fringe
    @cells.inject(Set.new) do |fringe_cells, cell|
      fringe_cells + points_surrounding(cell[0], cell[1])
    end - @cells
  end

  def alive_neighbour_count(x, y)
    points_surrounding(x, y).count { |point| @cells.include? point }
  end
end

class ConwayAliveRules
  def initialize(board)
    @board = board
    self
  end

  def apply(x, y, number_of_neighbours)
    @board.come_alive_at(x, y) if (2..3).include?(number_of_neighbours)
  end
end

class ConwayDeadRules
  def initialize(board)
    @board = board
    self
  end

  def apply(x, y, number_of_neighbours)
    @board.come_alive_at(x, y) if number_of_neighbours == 3
  end
end
