require 'spec_helper'

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
