require_relative 'methods/methods'
require 'csv'

def solution_test(sudoku, grid_lines, grid_columns)
  grid_size = grid_lines * grid_columns

  sudoku_with_options = sudoku_with_options(grid_lines, grid_columns, sudoku)
  sudoku_with_uniques = get_sudoku_with_uniques(sudoku_with_options, grid_lines, grid_columns)

end


 ##################################################################################
 ##################################################################################

sudoku = sudoku_csv_parsing("methods/sudoku_3x3.csv", ";", ';')
grid_lines = grid_lines_method
grid_columns = grid_columns_method

puts "

with uniques

"
p sol = solution_test(sudoku, grid_lines, grid_columns)

puts "

grided

"
p grided = sudoku_grided(grid_lines, grid_columns, sol)

puts "

with uniques:

"
p uniques = get_sudoku_with_uniques(grided, grid_lines, grid_columns)

puts "

with uniques grided:

"

p final = sudoku_grided(grid_lines, grid_columns, uniques)

 ##################################################################################
 ##################################################################################

# def generate_sudoku_structure(grid_lines, grid_columns)
#   sudoku = []
#   grid_size = grid_lines * grid_columns

#   (0..grid_size - 1).to_a.each do
#     sudoku << []
#   end
#   sudoku.each do |line|
#     (0..grid_size - 1).to_a.each do
#       line << []
#     end
#   end

#   return sudoku.to_a
# end

# def rand_value(sudoku_structure, random_line, random_column, random_value, grid_lines, grid_columns)
#   grid_size = grid_lines * grid_columns
#   # if sudoku_structure[random_line][random_column] = []
#     sudoku_structure[random_line][random_column][0] = random_value
#     if get_sudoku_check?(sudoku_structure, grid_lines, grid_columns) == false
#       rand_value(sudoku_structure, random_line, random_column, rand(grid_size) + 1, grid_lines, grid_columns)
#     else
#       sudoku_structure[random_line][random_column][0] = random_value
#     end
#   # else
#     # rand_value(sudoku_structure, rand(grid_size) + 1, rand(grid_size) + 1, rand(grid_size) + 1, grid_lines, grid_columns)
#   # end
#   return sudoku_structure
# end

# def generate_sudoku(n, sudoku_structure, grid_lines, grid_columns)
#   grid_size = grid_lines * grid_columns
#   # if n == 1
#     rand_value(sudoku_structure, rand(grid_size), rand(grid_size), rand(grid_size) + 1, grid_lines, grid_columns)
#   # else
#   #   rand_value(generate_sudoku(n - 1, sudoku_structure, grid_lines, grid_columns), rand(grid_size), rand(grid_size), rand(grid_size) + 1, grid_lines, grid_columns)
#   # end
# end

# def get_generate_sudoku(n, sudoku_structure, grid_lines, grid_columns)
#   sudoku = generate_sudoku(1, sudoku_structure, grid_lines, grid_columns)
#   for i in 1..n
#     sudoku = generate_sudoku(i, sudoku, grid_lines, grid_columns)
#   end
#   return sudoku
# end

# #########################################################################
# #########################################################################

# grid_lines = grid_lines_method
# grid_columns = grid_columns_method


# puts "sudoku structure:

# "
# p sudoku_structure = generate_sudoku_structure(grid_lines, grid_columns)

# p sudoku = get_generate_sudoku(30, sudoku_structure, grid_lines, grid_columns)

# p sudoku
# p sudoku.flatten.length
# p get_sudoku_check?(sudoku, grid_lines, grid_columns)


# puts "sudoku with options:

# "
# p sudoku_with_options = sudoku_with_options(grid_lines, grid_columns, sudoku)

# puts "sudoku with uniques:

# "
# p sudoku_with_uniques = get_sudoku_with_uniques(sudoku_with_options, grid_lines, grid_columns)

# puts "sudoku solutions:

# "
# p sudoku_solutions = sudoku_solutions(sudoku_with_uniques, grid_lines, grid_columns)

# puts "results:

# "
# results(sudoku_solutions, grid_lines, grid_columns).each_with_index do |solution, i|
#   p "solution #{i + 1}: "
#   solution.each do |line|
#     p line
#   end
# end


