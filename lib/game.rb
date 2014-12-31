require 'forwardable'

class Game
  extend Forwardable

  def initialize(board)
    @board = board
    self
  end

  def_delegator :@board, :come_alive_at

  def output(ui)
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
end
