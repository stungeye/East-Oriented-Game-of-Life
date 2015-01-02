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

  def output(ui)
    @cells.each do |x, y|
      ui.draw_cell(x, y)
    end
    self
  end

  def apply_rules(alive_rules, dead_rules)
    apply_alive_rules(alive_rules)
    apply_dead_rules(dead_rules)
    self
  end

  def apply_alive_rules(rules)
    @cells.each do |x, y|
      rules.apply(x, y, alive_neighbour_count(x, y))
    end
    self
  end

  def apply_dead_rules(rules)
    fringe.each do |x, y|
      rules.apply(x, y, alive_neighbour_count(x, y))
    end
    self
  end

  private

  def points_surrounding(x, y)
    [[x - 1, y - 1], [x, y - 1], [x + 1, y - 1],
     [x - 1, y    ],             [x + 1, y    ],
     [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]].to_set
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
