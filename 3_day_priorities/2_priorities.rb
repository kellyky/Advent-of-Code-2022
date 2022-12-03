rucksacks = File.read("input.txt").split

module Priorities
  def priorities
    priorities = {}
    ("a".."z").to_a.each.with_index do |letter, i|
      priorities[letter] = i + 1
    end
    ("A".."Z").to_a.each.with_index do |letter, i|
      priorities[letter] = i + 1 + 26 
    end
    priorities
  end
end

class Rucksack
  include Priorities

  def initialize(rucksacks)
    @rucksacks = rucksacks
  end

  def calculate_priority
    common_letter.flatten.reduce(0) do |total, priority|
      total += priorities[priority]
    end
  end

  def common_letter
    groups_of_three(@rucksacks).map do |pack|
      first, mid, last = pack
      @chars_to_check = first.chars.sort.uniq

      @chars_to_check.filter do |checked_char|
        mid.include?(checked_char) && last.include?(checked_char)
      end
    end
  end


  def groups_of_three(arr)
    arr.each_slice(3).to_a
  end

end

backpack = Rucksack.new(rucksacks)
# puts backpack.common_letter
puts backpack.calculate_priority
