loads = File.read('puzzle_input.txt')

puts loads.is_a? String

line_of_elves = loads.split(/(\s)/)
line_of_elves.reject!{ |el| el == "\n" }
# print line_of_elves

elves = {}
groups = []

i = 0
while i < line_of_elves.count
  this_index = i
  last_index = i - 1

  if (line_of_elves[last_index] == "" || line_of_elves[last_index] ==nil) && line_of_elves[this_index] != ""
    groups.push(last_index)
  end


  i += 1
end

groups.each.with_index do |group, i|
  ending = groups[i]
  
  if i == 0
    beginning = 0
  else
    beginning = groups[i - 1]
  end
  
  elves[i] = line_of_elves
    .slice(beginning...ending).to_a
    .map(&:to_i)
    .sum
end

def get_max_cal_count(hash)
  hash.values.max
end

puts get_max_cal_count(elves)
