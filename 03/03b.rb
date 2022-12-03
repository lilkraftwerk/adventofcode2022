grouped = File.read("./03/input.txt").split("\n").each_slice(3).to_a

def get_common_article(groups)
  groups[0].chars.each do |char|
    return char if groups[1].include?(char) && groups[2].include?(char)
  end
end

def get_priority(char)
  return ("A".."Z").to_a.index(char) + 27 if char == char.upcase
  return ("a".."z").to_a.index(char) + 1
end

print grouped.map { |group| get_common_article(group) }.map { |char| get_priority(char) }.sum
