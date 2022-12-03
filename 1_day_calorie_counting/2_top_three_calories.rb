loads = File.read('puzzle_input.txt')

line_of_elves = loads.split(/(\s)/).reject!{ |el| el == "\n" }

elves = {}
groups = []

i = 0
while i < line_of_elves.count
  this_index = i
  last_index = i - 1

  if line_of_elves[last_index] == ""  && line_of_elves[this_index] != ""
    groups.push(last_index)
  end

  i += 1
end

groups.each.with_index do |group, i|
  beginning = i == 0 ? 0 : groups[i - 1] 
  ending = groups[i]
  
  elves[i] = line_of_elves
    .slice(beginning...ending).to_a
    .map(&:to_i)
    .sum
end

def get_max_cal_count(hash)
  hash.values.max(3).sum
end

puts get_max_cal_count(elves)
