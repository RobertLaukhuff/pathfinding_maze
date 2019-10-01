require "byebug"

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

  def find_goal
    # run program to find a path to the goal
    print "Starting the search...\n\n"
    
    until maze_end_found?
      check_surroundings
    end

    system("clear")
    print "...End of search!\n\n"
    p @current_path
    p @maze_array
    write_solution_to_file
    print "The solution has been written in file maze_solution.txt\n"
  end

  def write_solution_to_file
    File.open("maze_solution.txt", "w") do |f|
      @maze_array.each do |row|
        row.each do |marker|
          f.write "#{marker}"
        end
        f.write "\n"
      end
    end
  end

  def get_maze_target_loc(target)
    @maze_array.each_with_index do |line, idx|
      return [idx, line.index(target)] if line.index(target)
    end    
  end

  def check_surroundings
    # check the contents of the spaces above,
    # right, below, and left of the current_position
    row = @current_position[0]
    col = @current_position[1]

    above_current_position = [row - 1, col]
    right_of_current_position = [row, col + 1]
    below_current_position = [row + 1, col]
    left_of_current_position = [row, col - 1]

    if location_is_open?(above_current_position)
      move(above_current_position)
      return true
    elsif location_is_open?(right_of_current_position)
      move(right_of_current_position)
      return true
    elsif location_is_open?(below_current_position)
      move(below_current_position)
      return true
    elsif location_is_open?(left_of_current_position)
      move(left_of_current_position)
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
    set_next_position(next_position)
    add_position_to_path
    add_path_marker
  end

  def set_next_position(next_position)
    @current_position = next_position
  end

  def add_position_to_path
    @current_path << @current_position
  end

  def add_path_marker
    print "\n Add Path Marker\n"
    puts @maze_array[@current_position[0]][@current_position[1]]
    if @maze_array[@current_position[0]][@current_position[1]] == ' '
      @maze_array[@current_position[0]][@current_position[1]] = 'X'
    end
  end

  def add_deadend_marker
    @maze_array[@current_position[0], @current_position[1]] = '%'
  end

  def location_is_open?(location)
    # check if location is an empty space
    @maze_array[location[0]][location[1]] == " " || @maze_array[location[0]][location[1]] == "E"
  end

  def deadend?
    if !check_surroundings
      print "You've reached a deadend.\n"
      print "Let's backtrack to the next available move.\n"
      return true
    end
    false 
  end
end

pf = PathFinder.new("./maze.txt")
# print "START: #{pf.maze_start_loc}\n"
# print "END: #{pf.maze_end_loc}\n"
# print "Current Position: #{pf.current_position}\n"
# print "Current Position Row: #{pf.current_position[0]}\n"
# print "Current Position Column: #{pf.current_position[1]}\n"
# print "Current Path Taken: #{pf.current_path}\n"
# print "Move: #{pf.move([2, 1])}\n"
# print "Current Position Updated: #{pf.current_position}\n"
pf.find_goal