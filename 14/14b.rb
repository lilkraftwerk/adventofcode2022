require "pry"

filename = "input.txt"
file_path = File.join(__dir__, filename)
all_lines =
    File
        .read(file_path)
        .split("\n")
        .map { _1.split(" -> ") }
        .map do |line|
            line.map { _1.split(",") }.map { |whole_line| whole_line.map(&:to_i) }
        end

@line_coords = []

def fill_lines(line)
    line.each_with_index do |coord, index|
        next_coord = line[index + 1]
        next if next_coord.nil?

        this_x, this_y = coord
        next_x, next_y = next_coord

        if this_x == next_x
            start_y, end_y = [this_y, next_y].sort
            (start_y..end_y).to_a.each do |current_y|
                @line_coords << [this_x, current_y]
            end
        end

        if this_y == next_y
            start_x, end_x = [this_x, next_x].sort
            (start_x..end_x).to_a.each do |current_x|
                @line_coords << [current_x, this_y]
            end
        end
    end
end

@line_hash = Hash.new { |h, k| h[k] = [] }
@sand_hash = Hash.new { |h, k| h[k] = [] }

all_lines.each { fill_lines(_1) }
@line_coords.uniq!

@line_coords.each do |coord|
    column, row = coord
    @line_hash[row] << column
end

def spot_is_taken(coords)
    col, row = coords
    @line_hash[row].include?(col) || @sand_hash[row].include?(col)
end

def spot_is_free(coords)
    col, row = coords
    (@line_hash[row].empty? || !@line_hash[row].include?(col)) &&
        (@sand_hash[row].empty? || !@sand_hash[row].include?(col))
end

@lowest_row = @line_coords.map { _1[1] }.max
@moves_exist = true

def move_sand
    current_row = 0
    current_column = 500

    while true
        down = [current_column, current_row + 1]
        left = [current_column - 1, current_row + 1]
        right = [current_column + 1, current_row + 1]

        # if just above floor
        if current_row == @lowest_row + 1
            @sand_hash[current_row] << current_column
            break
        end

        # // if all possible moves are taken
        if spot_is_taken(down) && spot_is_taken(left) && spot_is_taken(right)
            if [current_column, current_row] == [500, 0]
                @moves_exist = false
                break
            end

            @sand_hash[current_row] << current_column
            break
        end

        # if down is free
        if spot_is_free(down)
            current_row += 1
            next
        end

        if spot_is_free(left)
            current_column -= 1
            next
        end

        if spot_is_free(right)
            current_column += 1
            next
        end
    end
end

@total_moves = 0

while @moves_exist
    move_sand
    @total_moves += 1
end

puts @total_moves == 26_283
