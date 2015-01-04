require_relative '../lib/game_of_life.rb'

ruleset = RulesetWorldBuilder.new(ConwayAliveRules, ConwayDeadRules)

world = World.empty
world_coords = [[1, 1], [1, 2], [1, 3], [5, 5], [5, 6], [6, 5], [6, 6]]
world_coords.each do |x, y|
  world.come_alive_at(Coordinate2D.new(x, y))
end

3.times do
  ui = UserInterface2D.new(10, 10)
  world.output(ui)
  ui.print_world
  world = ruleset.next_world(world)
end
