require 'spec_helper'

describe WorldBuilder do
  context '#build_2d_world' do
    it 'should not add any locations to a world when given no data' do
      world = double
      WorldBuilder.build_2d_world(world)
    end

    it 'should add one location when provided a data for a 1x1 world' do
      world = double
      expect(world).to receive(:add_location)
      WorldBuilder.build_2d_world(world, [[double]])
    end
  end
end
