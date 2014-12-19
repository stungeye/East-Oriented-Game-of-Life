class WorldBuilder
  def self.build_2d_world(world, data = [[]])
    data.each_with_index do |row, y|
      row.each_with_index do |column, x|
        world.alive_location(Location.new(x,y))
      end
    end
    world
  end
end