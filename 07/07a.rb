require "pry"

filename = "input.txt"
file_path = File.join(__dir__, filename)
commands = File.read(file_path).split("\n")

dirs = []
dir_sizes = Hash.new(0)

commands.each do |command|
  split = command.split(" ")
  dirs.pop if command == "$ cd .."
  if split[1] == "cd" && split[2] != ".."
    if split[2] == "/"
      current_dir = ""
    else
      current_dir = split[2]
    end
    dirs << [dirs, current_dir].join("")
  end
  if split[0].to_i.to_s == split[0]
    dirs.each { |current_dir| dir_sizes[current_dir] += split[0].to_i }
  end
end

sum = dir_sizes.values.filter { _1 < 100_000 }.sum
puts sum == 1_427_048
