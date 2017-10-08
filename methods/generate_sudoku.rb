require_relative 'methods'
require_relative 'app_methods'


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

def generate_sudoku_n(n, sudoku_structure, grid_lines, grid_columns)
  grid_size = grid_lines * grid_columns

  authorized_lines = (0..grid_size - 1).to_a.sample(grid_size - grid_columns - 1)

  sudoku_structure.each_with_index do |line, line_index|
    if authorized_lines.include? line_index
      free_indexes = []
      line.each_with_index { |cell, cell_index| free_indexes << cell_index if cell.flatten.length == 0 }

      i = 1
      until i == grid_size
        rand_column = free_indexes.sample.to_i
        # rand_n = rand(grid_size) + 1
        # if rand_n == n
          sudoku_structure[line_index][rand_column] = [n]
        # else
        #   sudoku_structure[line_index][rand_column] = [n, rand_n]
        # end
        if get_sudoku_check?(sudoku_structure, grid_lines, grid_columns) == false
          sudoku_structure[line_index][rand_column] = []
        else
          i += 1
        end
      end
    end
  end
end

def get_generate_sudoku_n(n, sudoku_structure, grid_lines, grid_columns)
  for k in 1..n
    generate_sudoku_n(k, sudoku_structure, grid_lines, grid_columns)
  end
  return sudoku_structure
end

def get_sudoku_remove_error(sudoku, grid_lines, grid_columns)
  get_sudoku_check = get_sudoku_check(sudoku, grid_lines, grid_columns)
  get_sudoku_check_bin = get_sudoku_check?(sudoku, grid_lines, grid_columns)

  types = ["line", "column", "grid"]
  results = []
  if get_sudoku_check_bin == true
    results << "No error"
  else
    get_sudoku_check.each_with_index do |sudoku_check, sudoku_check_index|
      sudoku_check.each_with_index do |line, line_index|
        line.each do |key, value|
          if value > 1
            # results << "There are #{value} times the value #{key} in #{types[sudoku_check_index]} #{line_index + 1}"
            results << [value, key, types[sudoku_check_index], line_index]
          end
        end
      end
    end
  end

  # sudoku_transposed = sudoku_transposed(sudoku)

  # sudoku_grided = sudoku_grided(grid_lines, grid_columns, sudoku)

  results.each do |result|
    case result[2]
    when 'line'
      line = sudoku[result[3]].map { |cell| cell[0] == result[1] ? [] : cell }
      sudoku[result[3]] = line
    when 'column'
      column = sudoku_transposed(sudoku)[result[3]].map { |cell| cell[0] == result[1] ? [] : cell }
      sudoku_transposed = sudoku_transposed(sudoku)
      sudoku_transposed[result[3]] = column
      sudoku = sudoku_transposed(sudoku_transposed)
    when 'grid'
      grid = sudoku_grided(grid_lines, grid_columns, sudoku)[result[3]].map { |cell| cell[0] == result[1] ? [] : cell }
      sudoku_grided = sudoku_grided(grid_lines, grid_columns, sudoku)
      sudoku_grided[result[3]] = grid
      sudoku = sudoku_grided(grid_lines, grid_columns, sudoku_grided)
    end
  end
  return sudoku
end



######################################################################

grid_lines = grid_lines_method
grid_columns = grid_columns_method
grid_size = grid_lines * grid_columns

p sudoku_structure = generate_sudoku_structure(grid_lines, grid_columns)




(1..grid_size).to_a.shuffle.each_with_index do |option, option_index|
  sudoku_structure[0][option_index] = [option]
end

p sudoku_structure

(1..grid_size - 1).to_a.each do |i|
  until sudoku_structure[i].flatten.length == grid_size
    sudoku_structure[i].each_with_index do |cell, cell_index|
      (1..grid_size).to_a.shuffle.each do |option|
        unless sudoku_structure[i].flatten.include? option
          unless sudoku_transposed(sudoku_structure)[cell_index].flatten.include? option
            unless sudoku_grided(grid_lines, grid_columns, sudoku_structure)[i / grid_lines * grid_lines + cell_index / grid_columns].flatten.include? option
              cell[0] = option
            end
          end
        end
      end
    end
  end
end

sudoku_structure.each do |line|
  p line
end

p sudoku_structure.flatten.length
p get_sudoku_check?(sudoku_structure, grid_lines, grid_columns)
# p one_solution?(sudoku_structure, grid_lines, grid_columns)



# 10.times do

#   array = []

#   array << sudoku_structure

#   sample_line = (0..grid_size - 1).to_a.sample
#   sample_cell = (0..grid_size - 1).to_a.sample

#   sudoku_structure[sample_line][sample_cell] = []

#   sudoku_structure.each do |line|
#     p line
#   end

#   puts "

#   "

#   p one_solution?(array[-1], grid_lines, grid_columns)
# end



