require 'spec_helper'

describe World do
  let(:ui) { double(:user_interface) }

  context 'when empty' do
    subject(:world) { World.empty }

    it 'outputs nothing to the ui' do
      expect(ui).to_not receive(:draw_cell)
      world.output(ui)
    end

    it 'applies no alive rules' do
      alive_rules = double
      expect(alive_rules).to_not receive(:apply)
      world.apply_alive_rules(alive_rules)
    end

    it 'applies no dead rules' do
      dead_rules = double
      expect(dead_rules).to_not receive(:apply)
      world.apply_dead_rules(dead_rules)
    end
  end

  context 'with one live cell' do
    let(:live_cell) { Coordinate2D.new(1, 1) }
    subject(:world) { World.empty.come_alive_at(live_cell) }

    it 'outputs the cell to the ui' do
      expect(ui).to receive(:draw_cell).with(live_cell).once
      world.output(ui)
    end

    it 'does prevents duplicates of living cells' do
      world.come_alive_at(live_cell)
      expect(ui).to receive(:draw_cell).with(live_cell).once
      world.output(ui)
    end

    it 'allows new cells to be brought to life' do
      world.come_alive_at(Coordinate2D.new(1, 2))
      expect(ui).to receive(:draw_cell).twice
      world.output(ui)
    end

    it 'applies the alive rules once' do
      alive_rules = double
      expect(alive_rules).to receive(:apply)
      world.apply_alive_rules(alive_rules)
    end

    it 'applies the dead rules all neighbouring cells' do
      dead_rules = double
      expect(dead_rules).to receive(:apply).at_least(:once)
      world.apply_dead_rules(dead_rules)
    end
  end
end

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

describe Coordinate2D do
  subject(:coordinate2D) { Coordinate2D.new(1, 1) }
  describe '#neighbouring_coordinates' do
    it 'does not include itself in the neighbourhood' do
      expect(coordinate2D.neighbouring_coordinates).to_not include(coordinate2D)
    end
  
    it 'includes the correct neighbours' do
      expect(coordinate2D.neighbouring_coordinates).to include(
        Coordinate2D.new(0, 0), Coordinate2D.new(0, 1), Coordinate2D.new(0, 2),
        Coordinate2D.new(1, 0), Coordinate2D.new(1, 2),
        Coordinate2D.new(2, 0), Coordinate2D.new(2, 1), Coordinate2D.new(2, 2)
      )
    end
  end
end
