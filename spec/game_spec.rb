require 'spec_helper'

describe Game do
  describe '#come_alive_at' do
    let(:board) { double(:board) }
    subject(:game) { Game.new(board) }

    it 'forwards to the Board' do
      expect(board).to receive(:come_alive_at).with(1, 1)
      game.come_alive_at(1, 1)
    end
  end

  context 'when starting with an empty board' do
    let(:ui) { double(:user_interface).as_null_object }
    let(:board) { Board.empty }
    subject(:game) { Game.new(board) }

    it 'no live cells are ouput to the ui' do
      expect(ui).to have_not_received(:draw_cell)
      game.output(ui)
    end

    it 'cells that are brought to life are output to the ui' do
      expect(ui).to receive(:draw_cell).with(1, 1)
      game.come_alive_at(1, 1)
      game.output(ui)
    end
  end
end

describe Board do
  subject(:board) { Board.empty }

  it 'starts with all cells dead' do
    expect { |b| board.each_live_cell(&b) }.to_not yield_control
  end

  describe '#come_alive_at' do
    it 'allows a single cell to be brought to life' do
      board.come_alive_at(1, 1)
      expect { |b| board.each_live_cell(&b) }.to yield_control.exactly(1).times
    end

    it 'allows a multiple different cells to be brought to life' do
      board.come_alive_at(1, 1)
      board.come_alive_at(2, 2)
      expect { |b| board.each_live_cell(&b) }.to yield_control.exactly(2).times
    end

    it 'only allows a specific cell to be added once' do
      board.come_alive_at(1, 1)
      board.come_alive_at(1, 1)
      expect { |b| board.each_live_cell(&b) }.to yield_control.exactly(1).times
    end

    it 'can yield the correct number of fringe cells' do
      board.come_alive_at(1, 1)
      board.come_alive_at(1, 2)
      expect { |b| board.each_fringe_cell(&b) }.to yield_control.exactly(6).times
    end
  end
end
