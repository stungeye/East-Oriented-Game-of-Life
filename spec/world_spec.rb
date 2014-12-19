require 'spec_helper'

describe World do
  it 'should correct initialize as a World' do
    expect(World.new.class).to eq(World)
  end

  context 'An empty World' do
    before(:each) do
      @world = World.empty
    end

    it 'should self identify as being empty' do
      world_is_empty = false
      @world.empty?(-> { world_is_empty = true })
      expect(world_is_empty).to be true
    end

    it 'should remain empty after one tick' do
      world_is_empty = false
      @world.tick
      @world.empty?(-> { world_is_empty = true })
      expect(world_is_empty).to be true
    end

    it 'should no longer be empty after adding a cell' do
      location_of_cell = double
      world_is_empty = false
      @world.alive_at(location_of_cell)
      @world.empty?(-> { world_is_empty = true })
      expect(world_is_empty).to be false
    end
  end

  context 'A World of Lonely cells' do
    before(:each) do
      @world = World.empty
      @world.alive_at(double)
    end

    it 'a world with only lonely cells becomes empty after one tick' do
      pending "Need a WorldBuilder class first."
      world_is_empty = false
      @world.tick
      @world.empty?(-> { world_is_empty = true })
      expect(world_is_empty).to be true
    end
  end
end
