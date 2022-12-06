filename = "input.txt"
file_path = File.join(__dir__, filename)
formatted = File.read(file_path).split("\n").map { _1.split(",") }

def get_range(input)
  start_coord, end_coord = input.split("-")
  (start_coord.to_i..end_coord.to_i).to_a
end

def check_overlap(input)
  get_range(input[0]).none? { |coord| get_range(input[1]).include?(coord) }
end

result = formatted.map { check_overlap(_1) }.filter { _1 == false }.length
print result == 900
