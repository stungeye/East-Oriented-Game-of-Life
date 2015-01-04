require_relative '../lib/game_of_life.rb'

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
