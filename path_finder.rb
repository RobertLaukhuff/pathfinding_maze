class PathFinder

  attr_reader :maze_array, :maze_start_loc, :maze_end_loc, :current_position

  def initialize(maze_text_file)
    @file = File.new(maze_text_file, "r")
    @maze_array = @file.readlines.map { |line| line.chomp.split("") }
    @maze_start_loc = get_maze_target_loc('S')
    @maze_end_loc = get_maze_target_loc('E')
    @current_position = @maze_start_loc
    @current_path = []
  end

  def get_maze_target_loc(target)
    @maze_array.each_with_index do |line, idx|
      return [idx, line.index(target)] if line.index(target)
    end    
  end

  def check_surroundings
    # check the contents of the spaces above,
    # right, bottom, and left of the current_position
    # TODO: get above position [pos - 1, pos]
    # TODO: get right position [pos, pos + 1]
    # TODO: get bottom position [pos + 1, pos]
    # TODO: get left position [pos, pos - 1]
    # * be sure adding or subtracting doesn't overflow/underflow the array
    # * overflow/underflow shouldn't be an issue because there should be
    # * a wall surrounding the maze but be cautious just in case
  end

  def maze_end_found?
    # check if current_position equals maze_end_loc
    current_position == @maze_end_loc
  end

  def move
    # move current_position to next space
    # TODO: add next space to path array
    # TODO: update current_position to next space    
  end

  def is_location_open?(location)
    # check if location is an empty space
    location == nil
  end
end

pf = PathFinder.new("./maze.txt")
p pf.maze_start_loc
p pf.maze_end_loc