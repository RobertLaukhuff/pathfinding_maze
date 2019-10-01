# Open AppAcademy Ruby section Enumerables and Debugging subsection BONUS PROJECTS
class PathFinder

  attr_reader :maze_array, :maze_start_loc,
   :maze_end_loc, :current_position, :current_path

  def initialize(maze_text_file)
    @file = File.new(maze_text_file, "r")
    @maze_array = @file.readlines.map { |line| line.chomp.split("") }
    @maze_start_loc = get_maze_target_loc('S')
    @maze_end_loc = get_maze_target_loc('E')
    @current_position = @maze_start_loc
    @current_path = [@current_position]
  end

  def get_maze_target_loc(target)
    @maze_array.each_with_index do |line, idx|
      return [idx, line.index(target)] if line.index(target)
    end    
  end

  def check_surroundings
    # check the contents of the spaces above,
    # right, bottom, and left of the current_position
    # *INFO: use is_location_open?(location)
    # TODO: get above position [pos - 1, pos]
    # TODO: get right position [pos, pos + 1]
    # TODO: get bottom position [pos + 1, pos]
    # TODO: get left position [pos, pos - 1]
    # !WARN: be sure adding or subtracting doesn't overflow/underflow the array
    # !WARN: overflow/underflow shouldn't be an issue because there should be
    # !WARN: a wall surrounding the maze but be cautious just in case
    row = @current_position[0]
    col = @current_position[1]

    if @maze_array[row - 1, col] == " "
      move([row - 1, col])
      return true
    elsif @maze_array[row, col + 1] == " "
      move([row, col + 1])
      return true
    elsif @maze_array[row + 1, col] == " "
      move([row + 1, col])
      return true
    elsif @maze_array[row, col - 1] == " "
      move([row, col - 1])
      return true
    end
    return false
  end

  def maze_end_found?
    # check if current_position equals maze_end_loc
    current_position == @maze_end_loc
  end

  def move(next_position)
    # move current_position to next space
    # TODO: add next space to path array
    # TODO: update current_position to next space
    @current_position = next_position
  end

  def is_location_open?(location)
    # check if location is an empty space
    location == nil
  end

  def deadend?
    if !check_surroundings
      print "You've reached a deadend.\n"
      print "Let's backtrack to the next available move.\n"
    end
    # Check if the current_position is in a deadend
    # A deadend is a position where there are no
    # spaces to move and it is not the end of the maze
    # If it is a dead end, move back to the most recent
    # location and fill in the dead tile with D 
    # Continue to move back until a secondary path
    # opens up.
  end
end

pf = PathFinder.new("./maze.txt")
print "START: #{pf.maze_start_loc}\n"
print "END: #{pf.maze_end_loc}\n"
print "Current Position: #{pf.current_position}\n"
print "Current Position Row: #{pf.current_position[0]}\n"
print "Current Position Column: #{pf.current_position[1]}\n"
print "Current Path Taken: #{pf.current_path}\n"
print "Move: #{pf.move([2, 1])}\n"
print "Current Position Updated: #{pf.current_position}\n"
