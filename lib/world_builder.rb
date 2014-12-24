class WorldBuilder
  def self.build_2d_world(world, data = [[]])
    data.each_with_index do |row, y|
      row.each_with_index do |_cell, x|
        coordinate = Coordinate2D.new(x, y)
        world.add_location(coordinate)
      end
    end
    world
  end
end
