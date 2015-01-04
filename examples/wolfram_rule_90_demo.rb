require_relative '../lib/game_of_life.rb'

ruleset = RulesetWorldBuilder.new(Rule90, Rule90)

world = World.empty
world.come_alive_at(Coordinate1D.new(35))

32.times do
  ui = UserInterface1D.new(70)
  world.output(ui)
  ui.print_world
  world = ruleset.next_world(world)
end
