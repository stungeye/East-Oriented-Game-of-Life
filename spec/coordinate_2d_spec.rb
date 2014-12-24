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
end
