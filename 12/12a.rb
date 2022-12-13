require "pry"

filename = "input.txt"
file_path = File.join(__dir__, filename)
file = File.read(file_path).split("\n").map { _1.split("") }

char_vals = ["S", *("a".."z").to_a, "E"]

mapped =
    file.map do |row|
        row.map do |char|
            { char: char, height: char_vals.index(char), seen: false }
        end
    end

starting_row = file.index { |row| row.include?("S") }
starting_col = file[starting_row].index { |col| col == "S" }

def solve(grid, starting_points, ending_point, depth = 1)
    return if starting_points.empty?

    next_points = []

    starting_points.each do |x_point, y_point|
        grid[y_point][x_point][:seen] = true

        dirs =
            [
                [x_point, y_point + 1],
                [x_point, y_point - 1],
                [x_point + 1, y_point],
                [x_point - 1, y_point]
            ].reject { |x, y| x.negative? || y.negative? }
                .filter { |x, y| (x < grid.first.size) && (y < grid.size) }
                .reject { |x, y| grid[y][x][:seen] == true }
                .filter do |x, y|
                    (grid[y][x][:height] - grid[y_point][x_point][:height]) < 2
                end

        if starting_points.map { |x, y| grid[y][x][:char] }.include?(ending_point)
            return depth
        end

        next_points += dirs
    end

    solve(grid, next_points.uniq, ending_point, depth + 1)
end

puts solve(mapped, [[starting_col, starting_row]], "E") - 1 == 330
