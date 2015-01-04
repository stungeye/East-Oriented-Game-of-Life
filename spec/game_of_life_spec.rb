require 'spec_helper'

describe "Conway's Game of Life" do
  subject(:world) { World.empty }
  let(:ui) { spy(:user_interface) }
  let(:ruleset)   { RulesetWorldBuilder.new(ConwayAliveRules,
                                            ConwayDeadRules) }

  context 'with a static world configuration' do
    let(:points) { [[0, 0], [1, 0], [4, 0], [5, 0],
                    [0, 1], [1, 1], [4, 1], [6, 1],
                    [5, 2],
                    [1, 4], [2, 4],
                    [0, 5], [3, 5],
                    [1, 6], [2, 6]] }

    before { alive! points }

    it 'remains the same world' do
      new_world = ruleset.next_world(world)
      new_world.output(ui)
      points.each do |x, y|
        expect(ui).to have_received(:draw_cell).with(Coordinate2D.new(x, y))
      end
    end
  end

  context 'with an oscillating world configuration' do
    let(:phase_one_points) { [[1, 0], [5, 0], [6, 0],
                              [1, 1], [5, 1], 
                              [1, 2],
                              [8, 2],
                              [7, 3], [8, 3]] }

    let(:phase_two_points) { [[5, 0], [6, 0],
                              [0, 1], [1, 1], [2, 1], [5, 1], [6, 1],
                              [7, 2], [8, 2],
                              [7, 3], [8, 3]] }

    it 'transforms from phase one to phase two' do
      alive! phase_one_points
      new_world = ruleset.next_world(world)
      new_world.output(ui)
      phase_two_points.each do |x, y|
        expect(ui).to have_received(:draw_cell).with(Coordinate2D.new(x, y))
      end
    end

    it 'transforms from phase two to phase one' do
      alive! phase_two_points
      new_world = ruleset.next_world(world)
      new_world.output(ui)
      phase_one_points.each do |x, y|
        expect(ui).to have_received(:draw_cell).with(Coordinate2D.new(x, y))
      end
    end
  end

  def alive!(points)
    points.each do |x, y|
      world.come_alive_at(Coordinate2D.new(x, y))
    end
  end
end
