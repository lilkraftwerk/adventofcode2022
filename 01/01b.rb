max = File.read("./01/input.txt")
  .split("\n")
  .chunk { |item| item != "" }
  .to_a
  .filter { |x| x[0] == true }
  .map { |x| x[1] }
  .map { |arr| arr.map { |str| str.to_i } }
  .map { |arr| arr.sum }
  .sort
  .reverse
  .take(3)
  .sum

print max == 206643
