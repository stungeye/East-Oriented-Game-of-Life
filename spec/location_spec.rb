require 'spec_helper'

describe Location do
  before(:each) do
    @location = Location.new(double(:x), double(:y))
  end

  it 'should correctly initialize as a Location' do
    expect(@location.class).to eq(Location)
  end

  context '#same_position?' do
    it 'should recognize locations which share an identical position' do
      first_location = Location.new(1, 2)
      second_location = Location.new(1, 2)
      same_position = false
      first_location.same_position?(second_location,
                                    -> { same_position = true })
      expect(same_position).to be true
    end

    it 'should recognize locations which not not share an identical position' do
      first_location = Location.new(1, 2)
      second_location = Location.new(2, 3)
      same_position = false
      first_location.same_position?(second_location,
                                    -> { same_position = true })
      expect(same_position).to be false
    end
  end
end
