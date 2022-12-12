filename = "input.txt"
file_path = File.join(__dir__, filename)
formatted = File.read(file_path).split("\n").map { _1.split(",") }

def get_range(input)
  start_coord, end_coord = input.split("-")
  (start_coord.to_i..end_coord.to_i).to_a
end

def check_overlap(input)
  elf_1 = get_range(input[0])
  elf_2 = get_range(input[1])
  elf_2_contains_all = elf_2.all? { |coord| elf_1.include?(coord) }
  elf_1_contains_all = elf_1.all? { |coord| elf_2.include?(coord) }
  return elf_1_contains_all || elf_2_contains_all
end

result = formatted.map { check_overlap(_1) }.filter { _1 == true }.length
print result == 542
