require 'pry'

total_space = 70000000
space_needed = 30000000

filename = "input.txt"
file_path = File.join(__dir__, filename)
commands = File.read(file_path).split("\n")

dirs = []
dir_sizes = Hash.new(0)

commands.each do |command|
    split = command.split(" ")
    if command == "$ cd .."
        dirs.pop
    end
    if split[1] == "cd" && split[2] != ".."
        if split[2] == "/" 
            current_dir = "" 
        else
            current_dir = split[2]
        end
        dirs << [dirs, current_dir].join("")
    end
    if split[0].to_i.to_s == split[0] 
        dirs.each do |current_dir|
            dir_sizes[current_dir] += split[0].to_i
        end
    end
end

used_space = dir_sizes[""]
unused_space = total_space - used_space
possibilities = dir_sizes.values.filter do |value|
    unused_space + value > space_needed
end
puts possibilities.min