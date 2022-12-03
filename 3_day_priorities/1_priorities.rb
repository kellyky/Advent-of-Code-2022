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

class RucksackReorganization
  include Priorities

  def initialize(rucksacks)
    @rucksacks = rucksacks
  end

  def get_priorities
    divide_into_compartments.flatten.reduce(0) do |total, priority|
      total += priorities[priority]
    end
  end

  def divide_into_compartments
    @rucksacks.map.with_index do |sack, i|
      left, right = compartments(sack)

      @left_letters = left.chars.sort.uniq

      @left_letters.filter do |left|
        right.include?(left)
      end
    end
  end

  def compartments(arr)
    mid = arr.length / 2
    [arr.slice(0...mid), arr.slice(mid..-1)]
  end

end

backpack = RucksackReorganization.new(rucksacks)
puts backpack.get_priorities
