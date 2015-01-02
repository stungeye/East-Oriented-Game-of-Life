require 'spec_helper'

describe Board do
  let(:ui) { double(:user_interface) }

  context 'when empty' do
    subject(:board) { Board.empty }

    it 'outputs nothing to the ui' do
      expect(ui).to_not receive(:draw_cell)
      board.output(ui)
    end

    it 'applies no alive rules' do
      alive_rules = double
      expect(alive_rules).to_not receive(:apply)
      board.apply_rules(alive_rules, double(:dead_rules))
    end

    it 'applies no dead rules' do
      dead_rules = double
      expect(dead_rules).to_not receive(:apply)
      board.apply_rules(double(:alive_rules), dead_rules)
    end
  end

  context 'with one live cell' do
    subject(:board) { Board.empty.come_alive_at(1, 1) }

    it 'outputs the cell to the ui' do
      expect(ui).to receive(:draw_cell).with(1, 1).once
      board.output(ui)
    end

    it 'does prevents duplicates of living cells' do
      board.come_alive_at(1, 1)
      expect(ui).to receive(:draw_cell).with(1, 1).once
      board.output(ui)
    end

    it 'allows new cells to be brought to life' do
      board.come_alive_at(1, 2)
      expect(ui).to receive(:draw_cell).twice
      board.output(ui)
    end

    it 'applies the alive rules once' do
      alive_rules = double
      dead_rules  = double.as_null_object
      expect(alive_rules).to receive(:apply)
      board.apply_rules(alive_rules, dead_rules)
    end

    it 'applies the dead rules all neighbouring cells' do
      alive_rules = double.as_null_object
      dead_rules = double
      expect(dead_rules).to receive(:apply).at_least(:once)
      board.apply_rules(alive_rules, dead_rules)
    end
  end
end

describe ConwayAliveRules do
  let(:board) { double(:board) }
  subject(:alive_rules) { ConwayAliveRules.new(board) }

  it 'keeps a cell alive if it has two neighbours' do
    expect(board).to receive(:come_alive_at).with(1, 1)
    alive_rules.apply(1, 1, 2)
  end

  it 'keeps a cell alive if it has three neighbours' do
    expect(board).to receive(:come_alive_at).with(1, 1)
    alive_rules.apply(1, 1, 3)
  end

  it 'does not keep a lonely cell alive' do
    expect(board).to_not receive(:come_alive_at).with(1, 1)
    alive_rules.apply(1, 1, 0)
  end

  it 'does not keep a crowded cell alive' do
    expect(board).to_not receive(:come_alive_at).with(1, 1)
    alive_rules.apply(1, 1, 4)
  end
end

describe ConwayDeadRules do
  let(:board) { double(:board) }
  subject(:dead_rules) { ConwayDeadRules.new(board) }

  it 'brings a cell to life if it has three neighbours' do
    expect(board).to receive(:come_alive_at).with(1, 1)
    dead_rules.apply(1, 1, 3)
  end

  it 'does not bring lonely cell to life' do
    expect(board).to_not receive(:come_alive_at).with(1, 1)
    dead_rules.apply(1, 1, 0)
  end

  it 'does bring a crowded cell to life' do
    expect(board).to_not receive(:come_alive_at).with(1, 1)
    dead_rules.apply(1, 1, 4)
  end
end
