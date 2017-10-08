require 'timeout'
require 'csv'
require_relative 'methods'


# sudoku = sudoku_csv_parsing("sudoku_3x3_hard.csv", ";", ';')  # [[[1], [], [6], [], [], [], [], [7], []], [[], [], [7], [], [], [], [], [8], [3]], [[], [3], [], [6], [2], [7], [], [1], []], [[8], [9], [], [1], [], [5], [], [], []], [[], [], [], [3], [], [], [4], [2], [9]], [[4], [6], [], [7], [9], [], [1], [], [8]], [[6], [8], [9], [], [], [], [], [], []], [[], [], [], [8], [], [], [7], [], [2]], [[], [], [], [], [5], [9], [], [], []]]
# grid_lines = grid_lines_method
# grid_columns = grid_columns_method

# puts "

# SOLUTION:

# "

# solution = solution(grid_lines, grid_columns, sudoku)

# solution.each { |line| p line }

# p one_solution?(sudoku, grid_lines, grid_columns)

#################################################################################
# WHOLE APP:
#################################################################################


sudoku_dimensions = {
  "2x2" => [2, 2],
  "2x3" => [2, 3],
  "2x4" => [2, 4],
  "2x5" => [2, 5],
  "2x6" => [2, 6],
  "3x3" => [3, 3],
  "3x4" => [3, 4],
  "3x5" => [3, 5],
  "4x4" => [4, 4],
  "4x5" => [4, 5],
  "5x5" => [5, 5]
}

puts "Sudoku Grids:


+ - + - + - + - + - + - + - + - + - +
|  |   |   |   |   |   |   |   |   |
+ - + - + - + - + - + - + - + - + - +
|   |   |   |   |   |   |   |   |   |
+ - + - + - + - + - + - + - + - + - +
|   |   |   |   |   |   |   |   |   |
+ - + - + - + - + - + - + - + - + - +
|   |   |   |   |   |   |   |   |   |
+ - + - + - + - + - + - + - + - + - +
|   |   |   |   |   |   |   |   |   |
+ - + - + - + - + - + - + - + - + - +
|   |   |   |   |   |   |   |   |   |
+ - + - + - + - + - + - + - + - + - +
|   |   |   |   |   |   |   |   |   |
+ - + - + - + - + - + - + - + - + - +
|   |   |   |   |   |   |   |   |   |
+ - + - + - + - + - + - + - + - + - +
|   |   |   |   |   |   |   |   |   |
+ - + - + - + - + - + - + - + - + - +


"

# 1. GET INPUT

puts "

Available dimensions: #{sudoku_dimensions.keys}

"

sudoku = sudoku_csv_parsing("#{grid_sudoku_method}", ";", ';')  # [[[1], [], [6], [], [], [], [], [7], []], [[], [], [7], [], [], [], [], [8], [3]], [[], [3], [], [6], [2], [7], [], [1], []], [[8], [9], [], [1], [], [5], [], [], []], [[], [], [], [3], [], [], [4], [2], [9]], [[4], [6], [], [7], [9], [], [1], [], [8]], [[6], [8], [9], [], [], [], [], [], []], [[], [], [], [8], [], [], [7], [], [2]], [[], [], [], [], [5], [9], [], [], []]]
grid_lines = grid_lines_method
grid_columns = grid_columns_method

# 2. SUDOKU WITH OPTIONS (SUDOKU, TRANSPOSE & GRIDS)
puts "

sudoku:

"

sudoku.each do |line|
  p line
end

puts "

sudoku check:

"

p check(sudoku, sudoku, grid_lines, grid_columns)

puts "

sudoku with options:

"

p sudoku_with_options = sudoku_with_options(grid_lines, grid_columns, sudoku)

puts "

sudoku with options check:

"

p check(sudoku, sudoku_with_options, grid_lines, grid_columns)


# 3. GET SUDOKU WITH UNIQUES: ITERATE OVER 3 TRANSFORMATIONS UNTIL ALL UNIQUES IDENTOFIED

puts "

get sudoku with uniques:

"

p sudoku_with_uniques = get_sudoku_with_uniques_without_grided(sudoku_with_options, grid_lines, grid_columns)

puts "

sudoku with uniques check:

"

p check(sudoku, sudoku_with_uniques, grid_lines, grid_columns)

puts "

get sudoku with uniques with grided:

"

p sudoku_with_uniques_with_grided = get_sudoku_with_uniques_with_grided(sudoku_with_uniques, grid_lines, grid_columns)

puts "

sudoku with uniques with grided check:

"

p check(sudoku, sudoku_with_uniques_with_grided, grid_lines, grid_columns)

puts "

SOLUTION:

"

solution = sudoku_with_uniques_with_grided

solution.each { |line| p line}

# 3. GET SUDOKU SOLUTIONS:

puts "

SOLUTIONS:

"

# puts "

# sudoku first solutions:

# "

sudoku_solutions = sudoku_solutions(sudoku_with_uniques, grid_lines, grid_columns)

# sudoku_solutions.each_with_index do |sol, i|
#   puts "solution #{i + 1}: "
#   p sol
#   p check(sudoku, sol, grid_lines, grid_columns)
# end

puts "

sudoku reccursive solutions:

"

results(sudoku_solutions, grid_lines, grid_columns).uniq.each_with_index do |sol, i|
  puts "solution #{i + 1}: "
  sol.each { |line| p line}
  p get_sudoku_check_error(sol, grid_lines, grid_columns)
  p check(sudoku, sol, grid_lines, grid_columns)
end





