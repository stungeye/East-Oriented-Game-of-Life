require 'spec_helper'

describe Location do
  before(:each) do
    @location = Location.new(double(:x), double(:y))
  end

  it 'should correctly initialize as a Location' do
    expect(@location.class).to eq(Location)
  end
end
