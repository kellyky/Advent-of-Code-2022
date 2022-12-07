# signal = "bvwbjplbgvbhsrlpgdmjqwftvncz"
signal = File.read("input.txt")
# puts signal

signal.chars.each.with_index do |ch, i|
  group = signal.slice(i, 14)
  if group.chars.uniq == group.chars
    puts i + 14
    return i + 14
  end
end
