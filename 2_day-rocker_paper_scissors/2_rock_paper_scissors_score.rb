rounds = File.read('input.txt').split("\n")

outcome_dictionary = {
  "X" => "lose",
  "Y" => "draw",
  "Z" => "win"
}

outcome_score = {
  "X" => 0,
  "Y" => 3,
  "Z" => 6 
}

get_losing_choice = {
  "A" => "C",   # rock defeats paper
  "B" => "A",   # paper defeats rock
  "C" => "B"    # scissors defeats paper
}

get_winning_choice = get_losing_choice.invert

score_by_choice = {
  "A" => 1,
  "B" => 2,
  "C" => 3,
}

score = 0
rounds.each do |turn|
  opponent_choice, outcome = turn[0], turn[-1]
  score += outcome_score[outcome]

  case outcome_dictionary[outcome] 
  when "draw"
    score += score_by_choice[opponent_choice]
  when "win"
    my_choice = get_winning_choice[opponent_choice]
    score += score_by_choice[my_choice] 
  when "lose"
    my_choice = get_losing_choice[opponent_choice]
    score += score_by_choice[my_choice] 
  end
end

puts score
