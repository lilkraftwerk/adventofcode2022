require "pry"
require "set"

def coord_to_str(coord)
    x, y = coord
    "#{x},#{y}"
end

def manhattan_distance(start_coord, end_coord)
    (start_coord[0] - end_coord[0]).abs + (start_coord[1] - end_coord[1]).abs
end

def get_radius(element)
    (element[:sensor][:x] - element[:beacon][:x]).abs +
        (element[:sensor][:y] - element[:beacon][:y]).abs
end

filename = "input.txt"
file_path = File.join(__dir__, filename)
@sensors =
    File
        .read(file_path)
        .split("\n")
        .map do |line|
            sensor, beacon = line.split(": ")
            sensor.sub!("Sensor at x=", "")
            sensor.sub!(" y=", "")
            sensor_nums = sensor.split(",").map(&:to_i)
            beacon.sub!("closest beacon is at x=", "")
            beacon.sub!(" y=", "")
            beacon_nums = beacon.split(",").map(&:to_i)
            {
                sensor: {
                    x: sensor_nums[0],
                    y: sensor_nums[1]
                },
                beacon: {
                    x: beacon_nums[0],
                    y: beacon_nums[1]
                },
                distance: manhattan_distance(sensor_nums, beacon_nums)
            }
        end

@max_value = 4_000_000

def merge_intervals(intervals)
    sorted = intervals.sort
    merged = [intervals.first]

    for interval_i in 0...intervals.length
        start_point, end_point = sorted[interval_i]
        prev = merged[merged.length - 1]
        if prev[1] >= start_point
            prev[1] = [prev[1], end_point].max
        else
            merged << sorted[interval_i]
        end
    end
    merged
end

def get_points_on_line(line_y, sensor, radius)
    diff = (line_y - sensor[:y]).abs
    return [] if radius < diff
    return sensor[:x], sensor[:x] if diff == radius
    return sensor[:x] - (radius - diff), sensor[:x] + (radius - diff)
end

def get_range_on_line(current_i)
    intervals = []
    @sensors.each do |element|
        radius = get_radius(element)
        points = get_points_on_line(current_i, element[:sensor], radius)
        intervals << points if points.length > 0
    end
    merged = merge_intervals(intervals)
    merged
end

for current_i in 0..@max_value
    result = get_range_on_line(current_i)
    puts current_i if current_i % 250_000 == 0
    if result.length > 1
        puts "answer:"
        found_point = { x: result[0][1] + 1, y: current_i }
        answer = found_point[:x] * @max_value + found_point[:y]
        puts answer
        break
    end
end
