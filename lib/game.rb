require 'forwardable'

class Game
  extend Forwardable

  def initialize(board)
    @board = board
    self
  end

  def_delegator :@board, :come_alive_at

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
  end

  def come_alive_at(x, y)
    @cells << [x, y]
  end

  def each_live_cell
    @cells.each do |cell|
      yield cell
    end
  end

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
end
