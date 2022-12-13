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
    i_lose = "X" == match[1]
    i_tie = "Y" == match[1]
    i_win = "Z" == match[1]

    rock_value = 1
    paper_value = 2
    scissors_value = 3

    loss = 0
    tie = 3
    win = 6

    opponent = RockPaperScissor.new(match[0])

    if opponent.type == :rock
        return scissors_value + loss if i_lose
        return rock_value + tie if i_tie
        return paper_value + win if i_win
    end

    if opponent.type == :scissors
        return paper_value + loss if i_lose
        return scissors_value + tie if i_tie
        return rock_value + win if i_win
    end

    if opponent.type == :paper
        return rock_value + loss if i_lose
        return paper_value + tie if i_tie
        return scissors_value + win if i_win
    end
end

print matches.map { |match| score_match(match) }.sum == 14_652
