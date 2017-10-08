require 'csv'

# GET SUDOKU DIMENSIONS

def grid_lines_method
  puts "Grid lines number:"
  grid_lines = gets.chomp.to_i
  return grid_lines.to_i
end

def grid_columns_method
  puts "Grid columns number:"
  grid_columns = gets.chomp.to_i
  return grid_columns.to_i
end

def grid_sudoku_method
  puts "Sudoku file name:"
  grid_sudoku = gets.chomp
  return grid_sudoku
end

# GET SUDOKU VALUES

def sudoku_csv_parsing(filepath, col_sep, quote_char)
  sudoku = []
  csv_options = { col_sep: col_sep, quote_char: quote_char }
  CSV.foreach(filepath, csv_options) do |row|
    array = []
    row.each { |element| element.to_i == 0 ? array << [] : array << [element.to_i] }
    sudoku << array
  end
  return sudoku
end

# SUDOKU GRIDS

def grid_size(grid_lines, grid_columns)
  grid_size = grid_lines * grid_columns
  return grid_size.to_i
end

def sudoku_grids(grid_lines, grid_columns, sudoku)
  sudoku_grids = []
  grid_size = grid_lines * grid_columns
  # grids
  for i in 0..grid_columns - 1
    for j in 0..grid_lines - 1
      grid = []
      for k in 0..grid_lines - 1
        grid << sudoku[i * grid_lines + k][j * grid_columns..j * grid_columns + grid_columns - 1]
      end
      sudoku_grids << grid.flatten
    end
  end
  return sudoku_grids
end

# SUDOKU TRANSFORMATIONS

def sudoku_transposed(sudoku)
  return sudoku.transpose
end

def sudoku_grided(grid_lines, grid_columns, sudoku)
  sudoku_grids = []
  grid_size = grid_lines * grid_columns
  # grids
  for i in 0..grid_columns - 1
    for j in 0..grid_lines - 1
      grid = []
      for k in 0..grid_lines - 1
        grid << sudoku[i * grid_lines + k][j * grid_columns..j * grid_columns + grid_columns - 1]
      end
      sudoku_grids << grid
    end
  end
  return sudoku_grids.map { |array| array.flatten(1) }
end

def sudoku_cleaned(sudoku_with_uniques)
  array = []
  uniques = []
  sudoku_with_uniques.each do |line|
    uniques_line = []
    line.each do |cell|
      if cell.size > 1
      else
        uniques_line << cell
      end
    end
    uniques << uniques_line
  end

  sudoku_with_uniques.each_with_index do |line, line_index|
    cleaned_line = []
    line.each do |cell|
      cleaned_cell = []
      cell.each do |option|
        cleaned_cell << option unless uniques[line_index].flatten.include? option  # && cell.size > 1
      end
      if cell.size > 1
        cleaned_line << cleaned_cell
      else
        cleaned_line << cell
      end
    end
    array << cleaned_line
  end

  return array
end





################################################################################
################################################################################

# 1. SUDOKU CHECK
# 2. SUDOKU SOLVER
# 3. SUDOKU GENERATOR

################################################################################
################################################################################

# 1. SUDOKU CHECK

################################################################################
################################################################################

def sudoku_check(sudoku, grid_lines, grid_columns)
  results = []
  sudoku.each do |line|
    line_check = Hash.new(0)
    line.each do |cell|
      if cell.length == 1
        line_check[cell[0]] += 1
      end
    end
    results << line_check
  end

  return results
end

def get_sudoku_check(sudoku, grid_lines, grid_columns)
  results = []

  sudoku_check = sudoku_check(sudoku, grid_lines, grid_columns)
  results << sudoku_check

  sudoku_transposed = sudoku_transposed(sudoku)
  sudoku_transposed_check = sudoku_check(sudoku_transposed, grid_lines, grid_columns)
  results << sudoku_transposed_check

  sudoku_grided = sudoku_grided(grid_lines, grid_columns, sudoku)
  sudoku_grided_check = sudoku_check(sudoku_grided, grid_lines, grid_columns)
  results << sudoku_grided_check

  return results
end

def get_sudoku_check?(sudoku, grid_lines, grid_columns)
  return get_sudoku_check(sudoku, grid_lines, grid_columns).flatten.all? do |check_hash|
    check_hash.all? { |key, value| value == 1 ? true : false }
  end
end

def get_sudoku_check_error(sudoku, grid_lines, grid_columns)
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
            results << "There are #{value} times the value #{key} in #{types[sudoku_check_index]} #{line_index + 1}"
          end
        end
      end
    end
  end

  return results
end

def compare_sudoku_two_to_one(sudoku_one, sudoku_two)
  results = []

  sudoku_one.each_with_index do |line, line_index|
    line.each_with_index do |cell, cell_index|
      if cell.length == 1
        if cell[0] == sudoku_two[line_index][cell_index][0]
          results << 1
        else
          results << 2
        end
      else
        results << 0
      end
    end
  end

  return results
end

def solution_correspond_initial?(sudoku_initial, sudoku_solution)
  compare_sudoku_two_to_one(sudoku_initial, sudoku_initial) == compare_sudoku_two_to_one(sudoku_initial, sudoku_solution) ? true : false
end


def check(sudoku_initial, sudoku, grid_lines, grid_columns)


  puts "get_sudoku_check?: #{get_sudoku_check?(sudoku, grid_lines, grid_columns)}"

  puts "get_sudoku_check_error: #{get_sudoku_check_error(sudoku, grid_lines, grid_columns)}"

  puts "solution_correspond_initial?: #{solution_correspond_initial?(sudoku_initial, sudoku)}"


end

def one_solution?(sudoku, grid_lines, grid_columns)
  grid_size = grid_lines * grid_columns
  sudoku_size = grid_size * grid_size

  sudoku_test = sudoku

  result = false

  if solution(grid_lines, grid_columns, sudoku_test).flatten.length == sudoku_size
    result = true
  else
    result = false
  end

  return result
end

################################################################################
################################################################################

# 2. SUDOKU SOLVER

################################################################################
################################################################################

# 1. SUDOKU WITH OPTIONS

def sudoku_with_options(grid_lines, grid_columns, sudoku)
  sudoku_grids = sudoku_grids(grid_lines, grid_columns, sudoku)
  sudoku_flatten = sudoku.map { |element| element.flatten }
  sudoku_transpose_flatten = sudoku.transpose.map { |element| element.flatten }

  sudoku_with_options = []
  line_index = 0

  sudoku_with_options = sudoku.each_with_index do |line, line_index|
    cell_index = 0
    line.each_with_index do |cell, cell_index|
      sudoku_grids_index = (line_index / grid_lines) * grid_lines + (cell_index / grid_columns)
      unless cell.length == 1
        (1..grid_size(grid_lines, grid_columns)).to_a.each do |i|
          cell << i unless sudoku_flatten[line_index].include?(i) || sudoku_transpose_flatten[cell_index].include?(i) || sudoku_grids[sudoku_grids_index].include?(i)
        end
      end
      cell_index += 1
    end
    line_index += 1
  end
  return sudoku_with_options
end

# 2. SUDOKU WITH UNIQUES
def sudoku_with_uniques(sudoku_with_options, grid_lines, grid_columns)
  (0..grid_size(grid_lines, grid_columns) - 1).to_a.each do |i|
    options = []
    sudoku_with_options[i].each { |array| options << array }
    options_hash = Hash.new(0)
    options.flatten.each { |j| options_hash[j] += 1 }
    uniques = []
    options_hash.each { |key, value| uniques << key if value == 1}
    uniques_hash = Hash.new
    uniques.each do |unique|
      sudoku_with_options[i].each_with_index do |array, index|
        uniques_hash[index] = unique if array.include?(unique)
      end
    end
    sudoku_with_uniques_i = []
    (0..grid_size(grid_lines, grid_columns) - 1).to_a.each do |j|
      uniques_hash[j].nil? ? sudoku_with_uniques_i << sudoku_with_options[i][j] : sudoku_with_uniques_i << [uniques_hash[j]]
    end
    sudoku_with_options[i] = sudoku_with_uniques_i
  end
  return sudoku_with_options
end

def get_sudoku_with_uniques_without_grided(sudoku_with_options, grid_lines, grid_columns)
  i = 0
  result = sudoku_with_options
  20.times do
    sudoku_zero = result
    # 1. with_uniques
    sudoku_one = sudoku_with_uniques(sudoku_zero, grid_lines, grid_columns)
    sudoku_one_cleaned = sudoku_cleaned(sudoku_one)
    # i += 1
    # puts "
    # #{i}  sudoku_one_cleaned
    #  "
    # p sudoku_one_cleaned
    # puts "   "
    # 2. transpose
    sudoku_two = sudoku_one_cleaned.transpose
    # 3. with_uniques
    sudoku_three = sudoku_with_uniques(sudoku_two, grid_lines, grid_columns)
    sudoku_three_cleaned = sudoku_cleaned(sudoku_three)
    # i += 1
    # puts "
    # #{i}  sudoku_three_cleaned
    #  "
    # p sudoku_three_cleaned
    # puts "   "
    # 4. transpose
    sudoku_four = sudoku_three_cleaned.transpose
    # 5. grid
    # sudoku_five = sudoku_grided(grid_lines, grid_columns, sudoku_four)
    # # 6. with_uniques
    # sudoku_six = sudoku_with_uniques(sudoku_five, grid_lines, grid_columns)
    # sudoku_six_cleaned = sudoku_cleaned(sudoku_six)
    # # 7. grid
    # sudoku_seven = sudoku_grided(grid_lines, grid_columns, sudoku_six_cleaned)
    # return
    result = sudoku_four
  end
    # sudoku_five = result

    # sudoku_six = sudoku_grided(grid_lines, grid_columns, result)

    # sudoku_seven = get_sudoku_with_uniques(sudoku_six, grid_lines, grid_columns)

    # result = sudoku_grided(grid_lines, grid_columns, sudoku_seven)

  return result
end

def get_sudoku_with_uniques_with_grided(sudoku_with_uniques, grid_lines, grid_columns)
    sudoku_six = sudoku_grided(grid_lines, grid_columns, sudoku_with_uniques)

    sudoku_seven = sudoku_with_uniques(sudoku_six, grid_lines, grid_columns)

    result = sudoku_grided(grid_lines, grid_columns, sudoku_seven)

    return result
end

def solution(grid_lines, grid_columns, sudoku)
  sudoku_with_options = sudoku_with_options(grid_lines, grid_columns, sudoku)
  sudoku_with_uniques = get_sudoku_with_uniques_without_grided(sudoku_with_options, grid_lines, grid_columns)
  sudoku_with_uniques_with_grided = get_sudoku_with_uniques_with_grided(sudoku_with_uniques, grid_lines, grid_columns)
  solution = sudoku_with_uniques_with_grided
  # return solution

  # # 2. SUDOKU WITH OPTIONS (SUDOKU, TRANSPOSE & GRIDS)

  # puts "

  # sudoku_with_options:

  # "

  # p sudoku_with_options = sudoku_with_options(grid_lines, grid_columns, sudoku)
  # print "get_sudoku_check?            "
  # p get_sudoku_check?(sudoku_with_options, grid_lines, grid_columns)
  # print "solution_correspond_initial? "
  # p solution_correspond_initial?(sudoku, sudoku_with_options)



  # # 3. GET SUDOKU WITH UNIQUES: ITERATE OVER 3 TRANSFORMATIONS UNTIL ALL UNIQUES IDENTOFIED

  # puts "

  # sudoku_with_uniques:

  # "

  # p sudoku_with_uniques = get_sudoku_with_uniques_without_grided(sudoku_with_options, grid_lines, grid_columns)
  # print "get_sudoku_check?            "
  # p get_sudoku_check?(sudoku_with_uniques, grid_lines, grid_columns)
  # print "solution_correspond_initial? "
  # p solution_correspond_initial?(sudoku, sudoku_with_uniques)


  # puts "

  # sudoku_with_uniques_grided:

  # "

  # p sudoku_with_uniques_with_grided = get_sudoku_with_uniques_with_grided(sudoku_with_uniques, grid_lines, grid_columns)
  # print "get_sudoku_check?            "
  # p get_sudoku_check?(sudoku_with_uniques_with_grided, grid_lines, grid_columns)
  # print "solution_correspond_initial? "
  # p solution_correspond_initial?(sudoku, sudoku_with_uniques_with_grided)



  # # SOLUTION:

  # puts "

  # SOLUTION:

  # "

  # p solution = sudoku_with_uniques_with_grided
  # print "get_sudoku_check?            "
  # p get_sudoku_check?(solution, grid_lines, grid_columns)
  # print "solution_correspond_initial? "
  # p solution_correspond_initial?(sudoku, solution)

  # return solution
end

# 3. SUDOKU SOLUTIONS

def sudoku_solutions(sudoku_with_uniques, grid_lines, grid_columns)
  lengths = []
  sudoku_with_uniques.each do |line|
    new_line = []
    line.each do |cell|
      new_line << cell.length
    end
    lengths << new_line
  end

  sudoku_size = grid_lines * grid_columns

  max_line_index = lengths.flatten.each_with_index.max[1]/sudoku_size
  max_cell_index = lengths.flatten.each_with_index.max[1]%(sudoku_size)
  max = sudoku_with_uniques[max_line_index][max_cell_index].length

  line_one = sudoku_with_uniques[max_line_index]
  line_one_max_length_index = lengths[max_line_index].each_with_index.max[1]
  line_one_max_length = lengths[max_line_index][line_one_max_length_index]

  array = []
  solutions = []

  (0..max - 1).to_a.each do |i|
    line_one.each_with_index do |cell, cell_index|
      if cell_index == line_one_max_length_index
        array << [line_one[line_one_max_length_index][i]]
      else
        array << cell
      end
    end
  end

  array.each_slice(sudoku_size) { |p| solutions << p}

  sudoku_solutions = []

  (0..max - 1).to_a.each do |i|
    sudoku_with_uniques.each_with_index do |line, line_index|
      if line_index == max_line_index
        sudoku_solutions << solutions[i]
      else
        sudoku_solutions << line
      end
    end
  end

  sudoku_solutions

  solutions = []

  sudoku_solutions.each_slice(sudoku_size) { |p| solutions << p}

  solutions.map! do |solution|
    get_sudoku_with_uniques_without_grided(solution, grid_lines, grid_columns)
  end

  # solutions.each_with_index do |solution, solution_index|
  #   puts "solution: #{solution_index}"
  #   solution.each do |line|
  #     p line
  #   end
  # end

  return solutions
end

def get_each(solutions, grid_lines, grid_columns)
  sudoku_size = grid_lines * grid_columns
  sudoku_dimension = sudoku_size * sudoku_size
  results = []
  solutions.each do |solution|
    if solution.flatten.length == sudoku_dimension
      results << solution
    elsif solution.flatten.length < sudoku_dimension
      puts "error"
    else
      array = sudoku_solutions(solution, grid_lines, grid_columns)
      array.each { |sol| results << sol unless sol.flatten.length < sudoku_dimension || get_sudoku_check?(sol, grid_lines, grid_columns) == false }
    end
  end
  return results
end

def get_all(n, solutions, grid_lines, grid_columns)
  if n == 1
    get_each(solutions, grid_lines, grid_columns)
  elsif n == 2
    get_each(get_all(1, solutions, grid_lines, grid_columns), grid_lines, grid_columns)
  else
    get_each(get_all(n - 1, solutions, grid_lines, grid_columns), grid_lines, grid_columns)
  end
end

def results(sudoku_solutions, grid_lines, grid_columns)
  # i = 2
  # stop = false
  # until stop == true
  #   stop = get_all(i + 1, sudoku_solutions, grid_lines, grid_columns).uniq == get_all(i, sudoku_solutions, grid_lines, grid_columns).uniq ? true : false
  #   i += 1
  # end

  i = 10

  results = []
  get_all(i, sudoku_solutions, grid_lines, grid_columns).uniq.each do |solution|
    if get_sudoku_check?(solution, grid_lines, grid_columns) == true
      results << solution
    end
  end

  return results
end




















