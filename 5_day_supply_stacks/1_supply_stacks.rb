require 'enumerator'
raw_schematic = File.read('input.txt') 
# raw_schematic = File.read('sample_input.txt') 

module Schematic
  def schematic
    @raw_schematic.split(/\s+/)
  end
end

module Directions
  include Schematic

  def initialize(raw_schematic)
    @raw_schematic = raw_schematic
  end

  def directions  # returns 2d array - with the numeric directions
    schematic.slice(directions_dividor..-1)
      .filter{ |el| el.match(/[0-9]/) }
      .map(&:to_i).enum_for(:each_slice, 3).to_a
  end

  def directions_dividor
    schematic.find_index("move")
  end

end

class CargoStacks
  include Schematic
  include Directions

  def initialize(raw_schematic)
    @raw_schematic = raw_schematic
  end

  def reorganize
    stacks = build_stacks

    directions.map do |direction|
      this_many, from, to = direction
      crane_load = stacks[from].pop(this_many).reverse 
      stacks[to] += crane_load
    end 

    stacks.values.map{ |v| v.last }.join
  end

  def build_stacks
    shipyard = {}
    for x in 1..9 # use for 'real' input
    # for x in 1..3 # use for sample input
      shipyard[x] = []
    end

    cargo = raw_cargo.gsub("  ", " ").chars

    cargo.each.with_index do |container, i|
      stack = 1 + (i % 9)   # change to 3 for real input
      # stack = 1 + (i % 3)   # change to 3 for real input
      next if container == nil || container == " "
      shipyard[stack] << container
    end

    # builds the "top" at the front or the arr ... we'll see if that works or I need to reverse that
    shipyard.map { |k, v| v.reverse! }
    shipyard
  end

  def raw_cargo
    # the -3 is b/c there's 3 extra characters between cargo and container numbers
    @raw_schematic
      .slice(0...cargo_dividor-3)
      .chars
      .reject{ |el| el == "[" || el == "]" }
      .filter.with_index { |el, i| i.even? unless el == "\n" }
      .join
  end

  def cargo_dividor
    @raw_schematic.index("1")
  end

end


new_stack = CargoStacks.new(raw_schematic)
puts new_stack.reorganize

