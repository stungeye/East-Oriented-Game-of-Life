require 'spec_helper'

describe Location do
  before(:each) do
    @location = Location.new(double(:coordinate))
  end

  it 'should correctly initialize as a Location' do
    expect(@location.class).to eq(Location)
  end

  context '#same_position?' do
    it 'should recognize locations which share an identical position' do
      coordinate = Coordinate2D.random
      first_location = Location.new(coordinate)
      second_location = Location.new(coordinate)
      expect(first_location.same_position?(second_location)).to be true
    end

    it 'should recognize locations which not not share an identical position' do
      first_location = Location.new(Coordinate2D.new(1, 2))
      second_location = Location.new(Coordinate2D.new(2, 3))
      expect(first_location.same_position?(second_location)).to be false
    end
  end
end
