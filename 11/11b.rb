require "pry"

filename = "input.txt"
file_path = File.join(__dir__, filename)
file = File.read(file_path).split("\n\n").map { _1.split("\n") }

def format_monkey(monkey_arr)
    monkey = {}
    monkey[:index] = monkey_arr.first.split(" ")[1].sub(":", "").to_i
    monkey[:items] = monkey_arr[1].split(": ")[1].split(", ").map(&:to_i)
    op = monkey_arr[2].split(" = ")[1]
    monkey[:operation] = eval "lambda { |old| " + op + " }"
    monkey[:op_string] = op
    monkey[:test_by] = monkey_arr[3].split("divisible by ")[1].to_i
    monkey[:if_true] = monkey_arr[4].split("to monkey ")[1].to_i
    monkey[:if_false] = monkey_arr[5].split("to monkey ")[1].to_i
    monkey[:count] = 0
    monkey
end

@monkeys = file.map { format_monkey(_1) }
@divisor = @monkeys.map { _1[:test_by] }.reduce(&:*)

def process_monkey(monkey)
    monkey[:items].length.times do |i|
        monkey[:count] += 1
        item = monkey[:items].shift
        processed = monkey[:operation].call(item) % @divisor

        if processed % monkey[:test_by] == 0
            @monkeys[monkey[:if_true]][:items] << processed
        else
            @monkeys[monkey[:if_false]][:items] << processed
        end
    end
end

10_000.times { @monkeys.each { process_monkey(_1) } }
puts @monkeys.map { _1[:count] }.sort.reverse.take(2).reduce(&:*) ==
              15_048_718_170
