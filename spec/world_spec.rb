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
