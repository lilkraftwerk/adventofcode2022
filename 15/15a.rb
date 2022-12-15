require "pry"
require "set"

@beacons = Set.new
@taken_coords = Set.new

def coord_to_str(coord)
    x, y = coord
    "#{x},#{y}"
end

filename = "input.txt"
file_path = File.join(__dir__, filename)
file =
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
            @beacons.add(coord_to_str(beacon_nums))
            [sensor_nums, beacon_nums]
        end

def manhattan_distance(start_coord, end_coord)
    (start_coord[0] - end_coord[0]).abs + (start_coord[1] - end_coord[1]).abs
end

@line_height = 2_000_000

file.each do |coord_set|
    sensor, beacon = coord_set
    radius = (beacon[0] - sensor[0]).abs + (beacon[1] - sensor[1]).abs
    distance = (sensor[1] - @line_height).abs
    if distance <= radius
        start_range = sensor[0] - (radius - distance)
        end_range = sensor[0] + (radius - distance)
        (start_range..end_range).to_a.each do |current|
            as_str = coord_to_str([current, @line_height])
            @taken_coords.add(as_str) unless @taken_coords.include?(as_str)
        end
    end
end

p (@taken_coords - @beacons).length
