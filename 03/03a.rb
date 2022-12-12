file = File.read("./03/input.txt").split("\n")

def get_priority(char)
  return ("A".."Z").to_a.index(char) + 27 if char == char.upcase
  return ("a".."z").to_a.index(char) + 1
end

def count_chars(line)
  result = Hash.new(0)
  line.chars.each { |char| result[char] += 1 }
  result
end

def process_line(line)
  first_half, second_half =
    line.chars.each_slice(line.length / 2).map(&:join).map { count_chars(_1) }

  first_half.keys.each { |char| return char if second_half[char] >= 1 }
end

print file.map { process_line(_1) }.map { get_priority(_1) }.sum == 7597
