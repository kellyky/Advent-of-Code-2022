# signal = "bvwbjplbgvbhsrlpgdmjqwftvncz"
signal = File.read("input.txt")
# puts signal

signal.chars.each.with_index do |ch, i|
  group = signal.slice(i, 4)
  if group.chars.uniq == group.chars
    puts i + 4
    return i + 4
  end
end
