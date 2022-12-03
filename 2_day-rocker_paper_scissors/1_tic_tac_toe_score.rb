rounds = File.read('input.txt').split("\n")

# rounds "my choices" to the samy_decoded_choice as opponent_choice's
decode_choce = {
  "X" => "A",   # rock
  "Y" => "B",   # paper
  "Z" => "C"    # scissors
}

what_beats_what = {
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

score = 0
rounds.each do |turn|
  round_score = 0
  opponent_choice, my_encoded_choice = turn[0], turn[-1]
  my_decoded_choice = decode_choce[my_encoded_choice]

  case
  when my_decoded_choice == opponent_choice
    round_score += score_by_win[:draw]
  when what_beats_what[my_decoded_choice] == opponent_choice
    round_score += score_by_win[:win]
  end
  round_score += score_by_choice[my_decoded_choice] 
  score += round_score
end

puts score

