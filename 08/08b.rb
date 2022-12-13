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

    tree_collections[:up] = (0..tree_row - 1)
        .map { |current_row| @tree_map[current_row][tree_column] }
        .reverse

    tree_collections[:down] = (tree_row + 1..@row_count - 1).map do |current_row|
        @tree_map[current_row][tree_column]
    end

    tree_collections[:left] = (0..tree_column - 1)
        .map { |current_column| @tree_map[tree_row][current_column] }
        .reverse

    tree_collections[:right] = (
        tree_column + 1..@column_count - 1
    ).map { |current_column| @tree_map[tree_row][current_column] }

    tree_collections
end

def get_trees_until_condition(tree_arr, height)
    result = []
    tree_arr.each do |this_tree|
        result << this_tree if this_tree < height
        if this_tree == height || this_tree > height
            result << this_tree
            return result
        end
    end
    result
end

def get_scenic_score(tree_row, tree_column)
    tree_height = @tree_map[tree_row][tree_column]
    tree_visibility_map = get_all_visibility_trees_for_tree(tree_row, tree_column)

    scenic_map =
        tree_visibility_map.values.map do |tree_arr|
            get_trees_until_condition(tree_arr, tree_height).length
        end

    scenic_map.inject(:*)
end

score =
    @tree_map
        .map
        .with_index do |row, row_index|
            row.map.with_index do |tree, col_index|
                get_scenic_score(row_index, col_index)
            end
        end
        .flatten
        .max

puts score
