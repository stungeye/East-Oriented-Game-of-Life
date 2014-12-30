require 'spec_helper'

describe Coordinate2D do
  it 'should correctly initialize as a Coordinate2d' do
    coordinate = Coordinate2D.new(double, double)
    expect(coordinate.class).to eq(Coordinate2D)
  end

  context '#==' do
    it 'should recognize coordinate equality' do
      first  = Coordinate2D.new(1, 1)
      second = Coordinate2D.new(1, 1)
      expect(first == second).to be true
    end

    it 'should recognize coordinate inequality' do
      first  = Coordinate2D.new(1, 1)
      second = Coordinate2D.new(2, 2)
      expect(first == second).to be false
    end
  end

  context '#neighbour?' do
    it 'should recognize its neighbours' do
      coordinate = Coordinate2D.new(0, 0)
      neighbour  = Coordinate2D.new(0, 1)
      expect(coordinate.neighbour?(neighbour)).to be true
    end

    it 'should recognize that identical coordinates are not neighbours' do
      first  = Coordinate2D.new(1, 1)
      second = Coordinate2D.new(1, 1)
      expect(first.neighbour?(second)).to be false
    end

    it 'should recognize that distant coordinates are not neighbours' do
      first  = Coordinate2D.new(0, 0)
      second = Coordinate2D.new(0, 2)
      expect(first.neighbour?(second)).to be false
    end
  end
end
