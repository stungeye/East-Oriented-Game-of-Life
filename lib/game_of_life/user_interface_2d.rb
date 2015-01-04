class UserInterface2D
  def initialize(width, height)
    @width = width
    @height = height
    @world = blank_world
    self
  end

  def draw_cell(coordinate)
    @world[coordinate.y][coordinate.x] = '#'
    self
  end

  def print_world
    @world.each do |row|
      row.each do |column|
        print column
      end
      puts
    end
    puts
    self
  end

  private

  def blank_world
    Array.new(@height) { Array.new(@width, '_') }
  end
end
