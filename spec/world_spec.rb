require 'spec_helper'

describe World do
  before(:each) do
    @empty_world = World.empty
  end

  it 'should correct initialize as a World' do
    expect(@empty_world.class).to eq(World)
  end

  it 'should be empty when first initialized' do
    mock = double
    expect(mock).to receive(:message)
    @empty_world.empty?(-> { mock.message })
  end

  it 'an empty world should remain empty after one tick' do
    mock = double
    expect(mock).to receive(:message)
    @empty_world.tick
    @empty_world.empty?(-> { mock.message })
  end

  it 'an empty world is no longer empty after adding a cell' do
    location_of_cell = double
    mock = double
    @empty_world.set_living_at(location_of_cell)
    @empty_world.empty?(-> { mock.message })
  end
end
