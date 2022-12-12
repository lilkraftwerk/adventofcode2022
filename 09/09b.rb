require "pry"

filename = "input.txt"
file_path = File.join(__dir__, filename)
file = File.read(file_path).split("\n").map { _1.split(" ") }

Location = Struct.new(:name, :x, :y)

@knots = []
10.times { |i| @knots << Location.new(i, 0, 0) }

def move_head(direction, amount)
  head = @knots[0]

  directions = { R: [1, 0], L: [-1, 0], U: [0, 1], D: [0, -1] }

  x_move, y_move = directions[direction.to_sym]
  head.x += x_move
  head.y += y_move
end

def move_knot(index)
  knot = @knots[index]
  prev_knot = @knots[index - 1]
  # overlapping
  return if knot.x == prev_knot.x && knot.y == prev_knot.y

  distance_x = prev_knot.x - knot.x
  distance_y = prev_knot.y - knot.y

  if distance_x == 2 && distance_y == 0
    knot.x += 1
    return
  end

  if distance_y == 2 && distance_x == 0
    knot.y += 1
    return
  end

  if distance_x == -2 && distance_y == 0
    knot.x -= 1
    return
  end

  if distance_y == -2 && distance_x == 0
    knot.y -= 1
    return
  end

  if distance_x.abs == 2 || distance_y.abs == 2
    if distance_x.negative?
      knot.x -= 1
    else
      knot.x += 1
    end
    if distance_y.negative?
      knot.y -= 1
    else
      knot.y += 1
    end
  end
end

tail_spots = []
file.each do |moveset|
  direction, amount = moveset
  amount.to_i.times do
    move_head(direction, amount)
    (1..9).to_a.each { |index| move_knot(index) }
    tail_spots << [@knots.last.x, @knots.last.y]
  end
end

p tail_spots.uniq.length == 2303
