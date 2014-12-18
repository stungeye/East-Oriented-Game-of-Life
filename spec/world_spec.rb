require 'spec_helper'

describe World do
  before(:each) do
    @empty_world = World.empty
  end

  it 'should correct initialize as a World' do
    expect(@empty_world.class).to eq(World)
  end

  it 'should be empty when first initialized' do
    world_is_empty = false
    @empty_world.empty?(-> { world_is_empty = true })
    expect(world_is_empty).to be true
  end

  it 'an empty world should remain empty after one tick' do
    world_is_empty = false
    @empty_world.tick
    @empty_world.empty?(-> { world_is_empty = true })
    expect(world_is_empty).to be true
  end

  it 'an empty world is no longer empty after adding a cell' do
    location_of_cell = double
    world_is_empty = false
    @empty_world.set_living_at(location_of_cell)
    @empty_world.empty?(-> { world_is_empty = true })
    expect(world_is_empty).to be false
  end
end
