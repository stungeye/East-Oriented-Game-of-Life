require_relative '../lib/game_of_life.rb'

ruleset = RulesetWorldBuilder.new(Rule30Alive, Rule30Dead)

world = World.empty
world.come_alive_at(Coordinate1D.new(50))

50.times do
  ui = UserInterface1D.new(101)
  world.output(ui)
  ui.print_world
  world = ruleset.next_world(world)
end
