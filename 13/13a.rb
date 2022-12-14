require "pry"

filename = "input.txt"
file_path = File.join(__dir__, filename)
file =
    File
        .read(file_path)
        .split("\n\n")
        .map { _1.split("\n") }
        .map { |arr| arr.map { eval(_1) } }

def in_right_order?(a, b)
    if a.is_a?(Integer) && b.is_a?(Integer)
        return true if a < b
        return false if b < a
        return :next
    elsif a.is_a?(Array) && b.is_a?(Array)
        max_length = [a.length, b.length].max
        a = a.fill(-1, a.length..max_length)
        b = b.fill(-1, b.length..max_length)
        result = a.map.with_index { |num, index| in_right_order?(num, b[index]) }
        a_bad = result.index(false).nil? ? -1 : result.index(false)
        a_good = result.index(true).nil? ? -1 : result.index(true)

        if a_bad != -1 && a_good != -1
            return false if a_bad < a_good
            return true if a_bad > a_good
        end
        return false if a_bad != -1
        return true if a_good != -1
        return :next
    else
        if a.is_a?(Integer)
            return true if a == -1
            return in_right_order?([a], b)
        else
            return false if b === -1
            return in_right_order?(a, [b])
        end
    end
end

mapped = file.map { |line| in_right_order?(line[0], line[1]) }

result = 0
indexes =
    mapped.each_index.select { |i| result += (i + 1) if mapped[i] == true }
p result
