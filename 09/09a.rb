require 'pry'

filename = "input.txt"
file_path = File.join(__dir__, filename)
file = File.read(file_path).split("\n").map { _1.split(" ")}

Location = Struct.new(:name, :x, :y)

@head = Location.new("head", 0, 0)
@tail = Location.new("tail", 0, 0)

def move_head(direction, amount)
    directions = {
        # x, y
        R: [1, 0],
        L: [-1, 0],
        U: [0, 1],
        D: [0, -1]
    }

    x_move, y_move = directions[direction.to_sym]
    @head.x += x_move
    @head.y += y_move 
end

def move_tail
    # overlapping
    return if @tail.x == @head.x && @tail.y == @head.y

    distance_x = @head.x - @tail.x
    distance_y = @head.y - @tail.y

    if distance_x == 2 && distance_y == 0
        @tail.x += 1
        return
    end

    if distance_y == 2 && distance_x == 0
        @tail.y += 1
        return
    end

    if distance_x == -2 && distance_y == 0
        @tail.x -= 1
        return
    end

    if distance_y == -2 && distance_x == 0
        @tail.y -= 1
        return
    end

    if distance_x.abs == 2 || distance_y.abs == 2
        if distance_x.negative?
            @tail.x -= 1
        else
            @tail.x += 1
        end
        if distance_y.negative?
            @tail.y -= 1
        else
            @tail.y += 1
        end
    end
end

tail_spots = []

file.each do |moveset|
    direction, amount = moveset
    amount.to_i.times do
        tail_spots << [@tail.x, @tail.y]
        move_head(direction, amount)
        move_tail
    end
end

p tail_spots.uniq.length == 5907