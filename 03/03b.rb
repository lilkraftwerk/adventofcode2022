file_path = File.join(__dir__, "03input.txt")
grouped = File.read(file_path).split("\n").each_slice(3).to_a

def get_common_article(groups)
  groups[0].chars.each do |char|
    return char if groups.all? { _1.include?(char) }
  end
end

def get_priority(char)
  return [*?a..?z, *?A..?Z].index(char)
end

print grouped.map { get_common_article(_1) }.map { get_priority(_1) }.sum == 2507
