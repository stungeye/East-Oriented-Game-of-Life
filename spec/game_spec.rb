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
      world.apply_rules(alive_rules, double(:dead_rules))
    end

    it 'applies no dead rules' do
      dead_rules = double
      expect(dead_rules).to_not receive(:apply)
      world.apply_rules(double(:alive_rules), dead_rules)
    end
  end

  context 'with one live cell' do
    subject(:world) { World.empty.come_alive_at(1, 1) }

    it 'outputs the cell to the ui' do
      expect(ui).to receive(:draw_cell).with(1, 1).once
      world.output(ui)
    end

    it 'does prevents duplicates of living cells' do
      world.come_alive_at(1, 1)
      expect(ui).to receive(:draw_cell).with(1, 1).once
      world.output(ui)
    end

    it 'allows new cells to be brought to life' do
      world.come_alive_at(1, 2)
      expect(ui).to receive(:draw_cell).twice
      world.output(ui)
    end

    it 'applies the alive rules once' do
      alive_rules = double
      dead_rules  = double.as_null_object
      expect(alive_rules).to receive(:apply)
      world.apply_rules(alive_rules, dead_rules)
    end

    it 'applies the dead rules all neighbouring cells' do
      alive_rules = double.as_null_object
      dead_rules = double
      expect(dead_rules).to receive(:apply).at_least(:once)
      world.apply_rules(alive_rules, dead_rules)
    end
  end
end

describe ConwayAliveRules do
  let(:world) { double(:world) }
  subject(:alive_rules) { ConwayAliveRules.new(world) }

  it 'keeps a cell alive if it has two neighbours' do
    expect(world).to receive(:come_alive_at).with(1, 1)
    alive_rules.apply(1, 1, 2)
  end

  it 'keeps a cell alive if it has three neighbours' do
    expect(world).to receive(:come_alive_at).with(1, 1)
    alive_rules.apply(1, 1, 3)
  end

  it 'does not keep a lonely cell alive' do
    expect(world).to_not receive(:come_alive_at).with(1, 1)
    alive_rules.apply(1, 1, 0)
  end

  it 'does not keep a crowded cell alive' do
    expect(world).to_not receive(:come_alive_at).with(1, 1)
    alive_rules.apply(1, 1, 4)
  end
end

describe ConwayDeadRules do
  let(:world) { double(:world) }
  subject(:dead_rules) { ConwayDeadRules.new(world) }

  it 'brings a cell to life if it has three neighbours' do
    expect(world).to receive(:come_alive_at).with(1, 1)
    dead_rules.apply(1, 1, 3)
  end

  it 'does not bring lonely cell to life' do
    expect(world).to_not receive(:come_alive_at).with(1, 1)
    dead_rules.apply(1, 1, 0)
  end

  it 'does bring a crowded cell to life' do
    expect(world).to_not receive(:come_alive_at).with(1, 1)
    dead_rules.apply(1, 1, 4)
  end
end
