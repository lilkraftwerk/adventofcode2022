matches = File.read("./02/input.txt").split("\n").map { _1.split(" ") }

class RockPaperScissor
  def initialize(char)
    @char = char
  end

  def type
    return :rock if %w[A X].include?(@char)
    return :paper if %w[B Y].include?(@char)
    return :scissors if %w[C Z].include?(@char)
  end
end

def score_match(match)
  rock_value = 1
  paper_value = 2
  scissors_value = 3

  loss = 0
  tie = 3
  win = 6

  opponent = RockPaperScissor.new(match[0])
  me = RockPaperScissor.new(match[1])

  if me.type == :rock
    return rock_value + loss if opponent.type == :paper
    return rock_value + tie if opponent.type == :rock
    return rock_value + win if opponent.type == :scissors
  end

  if me.type == :paper
    return paper_value + loss if opponent.type == :scissors
    return paper_value + tie if opponent.type == :paper
    return paper_value + win if opponent.type == :rock
  end

  if me.type == :scissors
    return scissors_value + loss if opponent.type == :rock
    return scissors_value + tie if opponent.type == :scissors
    return scissors_value + win if opponent.type == :paper
  end
end

print matches.map { |match| score_match(match) }.sum == 10_718
