require 'spec_helper'

describe ConwayAliveRules do
  let(:world) { double(:world) }
  let(:live_cell) { double(:coordinate2D) }
  subject(:alive_rules) { ConwayAliveRules.new(world) }

  it 'keeps a cell alive if it has two neighbours' do
    expect(world).to receive(:come_alive_at).with(live_cell)
    alive_rules.apply(live_cell, 2)
  end

  it 'keeps a cell alive if it has three neighbours' do
    expect(world).to receive(:come_alive_at).with(live_cell)
    alive_rules.apply(live_cell, 3)
  end

  it 'does not keep a lonely cell alive' do
    expect(world).to_not receive(:come_alive_at).with(live_cell)
    alive_rules.apply(live_cell, 0)
  end

  it 'does not keep a crowded cell alive' do
    expect(world).to_not receive(:come_alive_at).with(live_cell)
    alive_rules.apply(live_cell, 4)
  end
end

describe ConwayDeadRules do
  let(:world) { double(:world) }
  let(:dead_cell) { double(:coordinate2D) }
  subject(:dead_rules) { ConwayDeadRules.new(world) }

  it 'brings a cell to life if it has three neighbours' do
    expect(world).to receive(:come_alive_at).with(dead_cell)
    dead_rules.apply(dead_cell, 3)
  end

  it 'does not bring lonely cell to life' do
    expect(world).to_not receive(:come_alive_at).with(dead_cell)
    dead_rules.apply(dead_cell, 0)
  end

  it 'does bring a crowded cell to life' do
    expect(world).to_not receive(:come_alive_at).with(dead_cell)
    dead_rules.apply(dead_cell, 4)
  end
end
