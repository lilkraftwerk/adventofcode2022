require 'pry'

test = [
    ["mjqjpqmgbljsphdztnvjfqwrcgsmlb", 19],
    ["bvwbjplbgvbhsrlpgdmjqwftvncz", 23],
    ["nppdvjthqldpwncqszvftbrmjlhg", 23],
    ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 29],
    ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 26],
]

filename = "input.txt"
file_path = File.join(__dir__, filename)
file = File.read(file_path)

def get_marker(string)
    string.chars.each_index do |index|
        char_set = string.chars[index-13..index]
        if char_set.uniq.length == 14
            return index + 1
        end
    end
end

puts get_marker(file) == 2564