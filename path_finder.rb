class PathFinder

  attr_reader :maze_array, :maze_start_loc, :maze_end_loc

  def initialize(maze_text_file)
    @file = File.new(maze_text_file, "r")
    @maze_array = @file.readlines.map { |line| line.chomp.split("") }
    @maze_start_loc = get_maze_target_loc('S')
    @maze_end_loc = get_maze_target_loc('E')
    @current_position = @maze_start_loc 
  end

  def get_maze_target_loc(target)
    @maze_array.each_with_index do |line, idx|
      return [idx, line.index(target)] if line.index(target)
    end    
  end

  # def assign_maze_end_loc
  #   @maze_array.each_with_index do |line, idx|
  #     return [idx, line.index('E')] if line.index('E')
  #   end
  # end

  def current_position

  end

  def is_space_open?(current_position)

  end

  def print_variables
    p @maze_start
    p @maze_end
    p @file
    p @maze_array
  end
end

pf = PathFinder.new("./maze.txt")
# pf.assign_maze_start_loc
# pf.assign_maze_end_loc
p pf.maze_start_loc
p pf.maze_end_loc