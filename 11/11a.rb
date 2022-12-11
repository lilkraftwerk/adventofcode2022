require 'pry'

filename = "input.txt"
file_path = File.join(__dir__, filename)
file = File.read(file_path).split("\n\n").map {_1.split("\n")}

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
    monkey
end

@monkeys = file.map { format_monkey(_1)}
@count_map = Hash.new(0)

def process_monkey(monkey)
    monkey[:items].length.times do |i|
        @count_map[monkey[:index]] += 1
        item = monkey[:items].shift
        processed = monkey[:operation].call(item)
        divided = processed / 3
        tested = divided % monkey[:test_by] == 0

        if tested
            to_monkey = monkey[:if_true]
            @monkeys[to_monkey][:items] << divided
        else 
            to_monkey = monkey[:if_false]
            @monkeys[to_monkey][:items] << divided
        end
    end
end

20.times do 
    @monkeys.each do |monkey|
        process_monkey(monkey)
    end
end

puts @count_map.values.sort.reverse.take(2).reduce(&:*)