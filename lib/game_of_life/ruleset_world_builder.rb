class RulesetWorldBuilder
  def initialize(alive_rules_class, dead_rules_class)
    @alive_rules_class = alive_rules_class
    @dead_rules_class = dead_rules_class
  end

  def next_world(world)
    new_world = World.empty
    world.apply_alive_rules(@alive_rules_class.new(new_world))
    world.apply_dead_rules(@dead_rules_class.new(new_world))
    new_world
  end
end
