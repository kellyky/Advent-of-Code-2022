turns = File.read('input.txt').split("\n")
# print turns  # testing if I have file turns working ;-P
# puts ""

# turns "my choices" to the same as opponent's
convert = {
  "X" => "A",   # rock
  "Y" => "B",   # paper
  "Z" => "C"    # scissors
}

what_beats_what = {
  # choice => beats this other choice
  "A" => "C",   # rock defeats paper
  "B" => "A",   # paper defeats rock
  "C" => "B"    # scissors defeats paper
}

score_by_choice = {
  "A" => 1,
  "B" => 2,
  "C" => 3,
}

score_by_win = {
  win: 6,
  draw: 3,
  loss: 0
}

acc = 0
turns.each do |turn|
  round_score = 0
  opponent, me_plain = turn[0], turn[-1]
  me = convert[me_plain]
  case
  when me == opponent
    round_score += score_by_win[:draw]
  when what_beats_what[me] == opponent
    round_score += score_by_win[:win]
  end
  round_score += score_by_choice[me] 
  acc += round_score
end

puts acc


# puts turns.reduce() do |acc, turn|
#   opponent, me_plain = turn[0], turn[-1]
#   me = convert[me_plain]
#   case
#   when me == opponent
#     acc += score_by_win[:draw]
#   when what_beats_what[me] == opponent
#     acc += score_by_win[:win]
#   end
#   acc += score_by_choice[me]
# end
