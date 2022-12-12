require "pry"

filename = "input.txt"
file_path = File.join(__dir__, filename)

@tree_map =
  File
    .read(file_path)
    .split("\n")
    .map { _1.split("") }
    .map { |arr| arr.map(&:to_i) }
@row_count = @tree_map.length
@column_count = @tree_map.first.length

def get_all_visibility_trees_for_tree(tree_row, tree_column)
  tree_collections = {}

  tree_collections[:up] = (0..tree_row - 1).map do |current_row|
    @tree_map[current_row][tree_column]
  end

  tree_collections[:down] = (tree_row + 1..@row_count - 1).map do |current_row|
    @tree_map[current_row][tree_column]
  end

  tree_collections[:left] = (0..tree_column - 1).map do |current_column|
    @tree_map[tree_row][current_column]
  end

  tree_collections[:right] = (
    tree_column + 1..@column_count - 1
  ).map { |current_column| @tree_map[tree_row][current_column] }

  tree_collections
end

def is_tree_visible?(tree_row, tree_column)
  tree_height = @tree_map[tree_row][tree_column]
  tree_visibility_map = get_all_visibility_trees_for_tree(tree_row, tree_column)

  tree_visibility_map.values.any? do |list_of_trees|
    list_of_trees.empty? ||
      list_of_trees.all? { |current_tree| current_tree < tree_height }
  end
end

visible_count =
  @tree_map
    .map
    .with_index do |row, row_index|
      row.map.with_index do |tree, col_index|
        is_tree_visible?(row_index, col_index)
      end
    end
    .flatten
    .filter { _1 == true }
    .length

p visible_count == 1805
