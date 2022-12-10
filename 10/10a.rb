require 'pry'

filename = "input.txt"
file_path = File.join(__dir__, filename)
file = File.read(file_path).split("\n").map do |line|
    line == "noop" ? :noop : line.split(" ")[1].to_i
end

x_value = 1
cycle_values_hash = {}
future_values = Hash.new(0)
cycle = 1

300.times do |i|
    line = file[i]
    if line != :noop && !line.nil?
        future_values[cycle + 2] = line 
    end
    if line.is_a? Integer
        cycle_values_hash[cycle + 1] = x_value
        cycle += 2
    else 
        cycle += 1
    end
    x_value += future_values[cycle]
    cycle_values_hash[cycle] = x_value
end

intervals = [20, 60, 100, 140, 180, 220]
result = intervals.map do |interval|
    cycle_values_hash[interval] * interval
end

p result.sum == 13180