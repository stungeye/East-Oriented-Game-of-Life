require 'spec_helper'

describe World do
  before(:each) do
    @world = World.new
  end

  it "should correct initialize as a World" do
    expect(@world.class).to eq(World)
  end

  it "should be empty when first initialized" do
    mock = double()
    expect(mock).to receive(:message)
    @world.empty?(-> { mock.message() })
  end

  it "an empty world should remain empty after one tick" do
    mock = double()
    expect(mock).to receive(:message)
    @world.tick
    @world.empty?(-> { mock.message() })
  end
end
