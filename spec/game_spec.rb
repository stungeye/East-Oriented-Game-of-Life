require 'spec_helper'

describe Game do
  let(:ui) { double(:user_interface).as_null_object }
  subject(:game) { Game.new }

  it 'starts with all cells dead' do
    expect(ui).to have_not_received(:draw_cell)
    game.output(ui)
  end
end
