class Coordinate2D < Value.new(:x, :y)
  def neighbouring_coordinates
    neighbourhood = (-1..1).flat_map do |delta_x|
      (-1..1).map do |delta_y|
        Coordinate2D.new(self.x + delta_x, self.y + delta_y)
      end
    end
    neighbourhood.reject { |c| c == self }
  end
end
