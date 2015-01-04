class UserInterface1D
  def initialize(width)
    @width = width
    @world = blank_world
    self
  end

  def draw_cell(coordinate)
    @world[coordinate.x] = '#'
    self
  end

  def print_world
    @world.each do |column|
        print column
    end
    puts
    self
  end

  private

  def blank_world
    Array.new(@width, '_')
  end
end
