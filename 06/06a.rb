require "pry"

test = [
  ["mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7],
  ["bvwbjplbgvbhsrlpgdmjqwftvncz", 5],
  ["nppdvjthqldpwncqszvftbrmjlhg", 6],
  ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10],
  ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11]
]

filename = "input.txt"
file_path = File.join(__dir__, filename)
file = File.read(file_path)

def get_marker(string)
  string.chars.each_index do |index|
    char_set = string.chars[index - 3..index]
    return index + 1 if char_set.uniq.length == 4
  end
end

puts get_marker(file) == 1356
