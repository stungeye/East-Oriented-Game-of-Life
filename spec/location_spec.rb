require 'spec_helper'

describe Location do
  before(:each) do
    @location = Location.new(double(:x), double(:y))
  end

  it 'should correctly initialize as a Location' do
    expect(@location.class).to eq(Location)
  end

  it 'should recognize locations which an identical position' do
    first_location = Location.new(1, 2)
    second_location = Location.new(1, 2)
    same_position = false
    first_location.same_position?(second_location, -> { same_position = true })
    expect(same_position).to be true
  end
end
