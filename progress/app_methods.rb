require 'timeout'
require 'csv'
require_relative 'methods'


# sudoku = sudoku_csv_parsing("sudoku_3x3_2.csv", ";", ';')  # [[[1], [], [6], [], [], [], [], [7], []], [[], [], [7], [], [], [], [], [8], [3]], [[], [3], [], [6], [2], [7], [], [1], []], [[8], [9], [], [1], [], [5], [], [], []], [[], [], [], [3], [], [], [4], [2], [9]], [[4], [6], [], [7], [9], [], [1], [], [8]], [[6], [8], [9], [], [], [], [], [], []], [[], [], [], [8], [], [], [7], [], [2]], [[], [], [], [], [5], [9], [], [], []]]
# grid_lines = grid_lines_method
# grid_columns = grid_columns_method

# puts "

# SOLUTION:

# "

# solution = solution(grid_lines, grid_columns, sudoku)

# solution.each { |line| p line }

# p one_solution?(sudoku, grid_lines, grid_columns)

################################################################################

def generate_sudoku_structure(grid_lines, grid_columns)
  sudoku = []
  grid_size = grid_lines * grid_columns

  (0..grid_size - 1).to_a.each do
    sudoku << []
  end
  sudoku.each do |line|
    (0..grid_size - 1).to_a.each do
      line << []
    end
  end

  return sudoku.to_a
end

def generate_sudoku(n, sudoku_structure, grid_lines, grid_columns)
  grid_size = grid_lines * grid_columns

  until sudoku_structure.flatten.length >= n # one_solution?(sudoku_structure, grid_lines, grid_columns) == true
    line_number = rand(grid_size)
    column_number = rand(grid_size)

    value = [rand(grid_size) + 1]
    sudoku_structure[line_number][column_number] = value

    # i = 0
    until get_sudoku_check?(sudoku_structure, grid_lines, grid_columns) == true # || one_solution?(sudoku_structure, grid_lines, grid_columns)
      value = [rand(grid_size) + 1]
      sudoku_structure[line_number][column_number] = value
      # i += 1
    end

    # if get_sudoku_check?(sudoku_structure, grid_lines, grid_columns) == false
    #   until get_sudoku_check?(sudoku_structure, grid_lines, grid_columns) == true
    #     line_number = rand(grid_size)
    #     column_number = rand(grid_size)

    #     binear = rand(1)
    #     if binear == 1
    #       value = [rand(grid_size) + 1]
    #     else
    #       value = []
    #     end
    #     sudoku_structure[line_number][column_number] = value
    #   end

    # end
  end
  return sudoku_structure
end

# puts "

# Sudoku structure:

# "

# p sudoku_structure = generate_sudoku_structure(grid_lines, grid_columns)

# puts "

# Sudoku generated:

# "

def get_sudoku_generated(n, sudoku_structure, grid_lines, grid_columns)
  # timeout_in_seconds = 3
  # begin
  #   Timeout::timeout(timeout_in_seconds) do
      sudoku_generated = generate_sudoku(n, sudoku_structure, grid_lines, grid_columns)
  #   end
  # rescue Timeout::Error
  #   sudoku_generated = generate_sudoku(n - 10, sudoku_structure, grid_lines, grid_columns)
  # end

  return sudoku_generated
end

# puts "How many cells?"
# i = gets.chomp.to_i

# j = 0
# one_solution = false
# until one_solution == true || j == 10
#   sudoku_generated = get_sudoku_generated(i, sudoku_structure, grid_lines, grid_columns)
#   one_solution = one_solution?(sudoku_generated, grid_lines, grid_columns)
#   j += 1
# end


# p sudoku_generated = get_sudoku_generated(i, sudoku_structure, grid_lines, grid_columns)
# p sudoku_generated.flatten.length
# p get_sudoku_check?(sudoku_generated, grid_lines, grid_columns)

# sudoku_generated.each do |line|
#   p line
# end

# sudoku_generated.each do |line|

# end



# p sudoku_generated = get_sudoku_generated(sudoku_generated, sudoku_structure, grid_lines, grid_columns)
# p sudoku_generated.flatten.length
# p get_sudoku_check?(sudoku_generated, grid_lines, grid_columns)
# p one_solution?(sudoku_generated, grid_lines, grid_columns)

# stop = false

# until stop == true
#   result = generate_sudoku(30, sudoku_structure, grid_lines, grid_columns)
#   stop = one_solution?(result, grid_lines, grid_columns)
# end

# puts "

# RESULT:

# "

# p result
# p result.flatten.length
# p get_sudoku_check?(result, grid_lines, grid_columns)

#################################################################################
# WHOLE APP:
#################################################################################


# sudoku_dimensions = {
#   "2x2" => [2, 2],
#   "2x3" => [2, 3],
#   "2x4" => [2, 4],
#   "2x5" => [2, 5],
#   "2x6" => [2, 6],
#   "3x3" => [3, 3],
#   "3x4" => [3, 4],
#   "3x5" => [3, 5],
#   "4x4" => [4, 4],
#   "4x5" => [4, 5],
#   "5x5" => [5, 5]
# }

# puts "Sudoku Grids:


# + - + - + - + - + - + - + - + - + - +
# |   |   |   |   |   |   |   |   |   |
# + - + - + - + - + - + - + - + - + - +
# |   |   |   |   |   |   |   |   |   |
# + - + - + - + - + - + - + - + - + - +
# |   |   |   |   |   |   |   |   |   |
# + - + - + - + - + - + - + - + - + - +
# |   |   |   |   |   |   |   |   |   |
# + - + - + - + - + - + - + - + - + - +
# |   |   |   |   |   |   |   |   |   |
# + - + - + - + - + - + - + - + - + - +
# |   |   |   |   |   |   |   |   |   |
# + - + - + - + - + - + - + - + - + - +
# |   |   |   |   |   |   |   |   |   |
# + - + - + - + - + - + - + - + - + - +
# |   |   |   |   |   |   |   |   |   |
# + - + - + - + - + - + - + - + - + - +
# |   |   |   |   |   |   |   |   |   |
# + - + - + - + - + - + - + - + - + - +


# "

# # 1. GET INPUT

# puts "

# Available dimensions: #{sudoku_dimensions.keys}

# "

# sudoku = sudoku_csv_parsing("sudoku_3x3_hard.csv", ";", ';')  # [[[1], [], [6], [], [], [], [], [7], []], [[], [], [7], [], [], [], [], [8], [3]], [[], [3], [], [6], [2], [7], [], [1], []], [[8], [9], [], [1], [], [5], [], [], []], [[], [], [], [3], [], [], [4], [2], [9]], [[4], [6], [], [7], [9], [], [1], [], [8]], [[6], [8], [9], [], [], [], [], [], []], [[], [], [], [8], [], [], [7], [], [2]], [[], [], [], [], [5], [9], [], [], []]]
# grid_lines = grid_lines_method
# grid_columns = grid_columns_method

# # 2. SUDOKU WITH OPTIONS (SUDOKU, TRANSPOSE & GRIDS)
# puts "

# sudoku:

# "

# p sudoku

# puts "

# sudoku check:

# "

# p check(sudoku, sudoku, grid_lines, grid_columns)

# puts "

# sudoku with options:

# "

# p sudoku_with_options = sudoku_with_options(grid_lines, grid_columns, sudoku)

# puts "

# sudoku with options check:

# "

# p check(sudoku, sudoku_with_options, grid_lines, grid_columns)


# # 3. GET SUDOKU WITH UNIQUES: ITERATE OVER 3 TRANSFORMATIONS UNTIL ALL UNIQUES IDENTOFIED

# puts "

# get sudoku with uniques:

# "

# p sudoku_with_uniques = get_sudoku_with_uniques_without_grided(sudoku_with_options, grid_lines, grid_columns)

# puts "

# sudoku with uniques check:

# "

# p check(sudoku, sudoku_with_uniques, grid_lines, grid_columns)

# puts "

# get sudoku with uniques with grided:

# "

# p sudoku_with_uniques_with_grided = get_sudoku_with_uniques_with_grided(sudoku_with_uniques, grid_lines, grid_columns)

# puts "

# sudoku with uniques with grided check:

# "

# p check(sudoku, sudoku_with_uniques_with_grided, grid_lines, grid_columns)

# puts "

# SOLUTION:

# "

# solution = sudoku_with_uniques_with_grided

# solution.each { |line| p line}

# # 3. GET SUDOKU SOLUTIONS:

# puts "

# SOLUTIONS:

# "

# # puts "

# # sudoku first solutions:

# # "

# sudoku_solutions = sudoku_solutions(sudoku_with_uniques, grid_lines, grid_columns)

# # sudoku_solutions.each_with_index do |sol, i|
# #   puts "solution #{i + 1}: "
# #   p sol
# #   p check(sudoku, sol, grid_lines, grid_columns)
# # end

# puts "

# sudoku reccursive solutions:

# "

# results(sudoku_solutions, grid_lines, grid_columns).uniq.each_with_index do |sol, i|
#   puts "solution #{i + 1}: "
#   sol.each { |line| p line}
#   p get_sudoku_check_error(sol, grid_lines, grid_columns)
#   p check(sudoku, sol, grid_lines, grid_columns)
# end




