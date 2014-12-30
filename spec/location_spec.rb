require 'spec_helper'

describe Location do
  before(:each) do
    @location = Location.new(double(:coordinate))
  end

  it 'should correctly initialize as a Location' do
    expect(@location.class).to eq(Location)
  end

  it 'should recognize locations which share an identical position' do
    coordinate = Coordinate2D.random
    first_location = Location.new(coordinate)
    second_location = Location.new(coordinate)
    expect(first_location.same_position?(second_location)).to be true
  end
  
  it 'knows how many neighbours it has when provided a World' do
    world = World.empty
    coordinate = Coordinate2D.random
    location = Location.new(coordinate)
    world.add_location(location)
  end
end
