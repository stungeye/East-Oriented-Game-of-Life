require 'spec_helper'

describe WorldBuilder do
  before(:each) do
    @world_builder = WorldBuilder.new
  end

  it 'should correctly initialize as a WorldBuilder' do
    expect(@world_builder.class).to eq(WorldBuilder)
  end
end
