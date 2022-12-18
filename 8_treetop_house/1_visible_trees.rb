forest = File.read('sample_input.txt').split
# forest = File.read('input.txt').split

class Forest
  def initialize(forest)
    @forest = forest
  end


  def print_it
    @forest
  end

  def count_boundary_trees
    2 * (@forest.first.length + @forest.length)
  end

  def trees_visible_from_west
    # left to right
    @visible_trees = 0
    forest_map.each do |k, row|
      last_tree = 0

      row.each_with_index.reduce(0) do |memo, (x, i)|
        while x > last_tree
          @visible_trees += 1
          last_tree = x
        end
      end

    end
    @visible_trees
  end

  def trees_visible_from_east
    # right to left
  end

  def trees_visible_from_north
    # top to bottom
  end

  def trees_visible_from_south
    # bottom to top
  end

  def forest_map_from_west
    @tree_map = {}

    @forest.each.with_index do |row, i|
      @tree_map[i + 1] = row.chars.map(&:to_i)
    end

    @tree_map
  end

  def forest_map_from_east

  end

end

kettle_moraine = Forest.new(forest)
puts kettle_moraine.trees_visible_from_west

# def tree_map_reverse(forest_map)
#   forest_map.map do |k, v|
#     forest_map[k] = v.reverse
#   end
# end

# puts forest_map
# puts ""
# print tree_map_reverse(forest_map)
