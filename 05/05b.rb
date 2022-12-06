require 'pry'

filename = "input.txt"
file_path = File.join(__dir__, filename)
file = File.read(file_path)

split = file.split("\n")

chart_split_index = split.index('')
stacks = split[0..chart_split_index - 1]
moves = split[chart_split_index + 1..split.length - 1]

def process_stacks(stack_input)
    columns = stack_input.pop
    mapped = stack_input.map { _1.chars.each_slice(4).map(&:join).map(&:strip) }
    
    stack_map = Hash.new { |hsh, key| hsh[key] = [] }
    mapped.reverse.each do |crate_array|
        crate_array.each_with_index do |crate, index|
            stack_map[(index + 1).to_s] << crate[1] if crate != ""
        end
    end
    stack_map
end

def process_moves(move_input)
    move_input.map do |move_line|
        crate_num, move = move_line.split(" from ")
        move_nums = move.split(" ")
        [crate_num.split(" ")[1], move_nums[0], move_nums[2]]
    end
end

processed_stacks = process_stacks(stacks)
processed_moves = process_moves(moves)

def make_moves(stack_map, move_map)
    move_map.each do |moves|
        count, origin, destination = moves

        moved_crates = stack_map[origin].pop(count.to_i)
        stack_map[destination] = [*stack_map[destination], *moved_crates]
    end
    stack_map
end

answer = make_moves(processed_stacks, processed_moves).values.map(&:last).join('')
p answer