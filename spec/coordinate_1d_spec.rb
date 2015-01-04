require 'spec_helper'

describe Coordinate1D do
  subject(:coordinate1D) { Coordinate1D.new(1) }
  describe '#neighbouring_coordinates' do
    it 'does not include itself in the neighbourhood' do
      expect(coordinate1D.neighbouring_coordinates).to_not include(coordinate1D)
    end

    it 'to return exactly 2 neighbours' do
      expect(coordinate1D.neighbouring_coordinates.count).to eq(2)
    end

    it 'includes the correct neighbours' do
      expect(coordinate1D.neighbouring_coordinates).to include(Coordinate1D.new(0),
                                                               Coordinate1D.new(2))
    end
  end

end
