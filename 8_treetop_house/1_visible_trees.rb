forest = File.read('sample_input.txt').split
# forest = File.read('input.txt').split

class Forest
  def initialize(forest)
    @forest = forest
  end

  def total
    perimeter + interior  
  end

  def interior
    # @coords = from_east + from_west + from_south + from_north
    # @coords.uniq.count / 2
  end


  def perimeter_coord(x, y)
     x == (0 || trees_per_row || trees_per_row ) || y == (0 || trees_per_row || trees_per_row ) 
  end


  def from_west
    @west = get_visible_interior_trees(@forest).uniq
    @west
  end

  def from_east
    coords = get_visible_interior_trees(@forest).uniq

    coords.uniq.map do |coord|
      x, y = coord
      [trees_per_row - x, trees_per_row - y] 
    end
  end

  def from_north
    @north = get_visible_interior_trees(forest_columns)

    @north
    # @north.uniq.map do |coord|
    #   x, y = coord
    #   [x, y]
    #   # [y, x]
    # end
  end


  def from_south
    @south = get_visible_interior_trees(forest_columns)

    @south.uniq.map do |coord|
      x, y = coord
      [trees_per_row - x, trees_per_row - y] 
    end
  end

  def get_visible_interior_trees(arr)
    @interior_coords = []
    arr.each.with_index do |row, j|
      row.chars.each.with_index do |tree, i|
        unless perimeter_coord(i, j)
          this_tree = tree.to_i
          last_tree = row[j - 1].to_i 
          if this_tree > last_tree
            @interior_coords.push([i, j])
          end
        end
      end
    end 

    @interior_coords
  end

  def perimeter
    4 * trees_per_row - 4
  end

  def trees_per_row
    @forest.first.length
  end

  def forest_columns
    @forest_columns = tree_columns_to_rows(@forest)
  end

  def tree_columns_to_rows(arr)
    (0...arr.length).to_a.map do |i|
      (0...arr[i].length).map { |j| arr[j][i] }.join
    end
  end

end

kettle_moraine = Forest.new(forest)
puts "perimeter trees: #{kettle_moraine.perimeter}"

puts "visible trees from the west: #{kettle_moraine.from_west}"
puts "visible trees from the east: #{kettle_moraine.from_east}"
puts "east/west: #{kettle_moraine.from_west.concat(kettle_moraine.from_east).uniq}"

puts "\nvisible trees from the north: #{kettle_moraine.from_north}"
puts "visible trees from the south: #{kettle_moraine.from_south}"

puts "north/south: #{kettle_moraine.from_north.concat(kettle_moraine.from_south).uniq.map{ |coord| coord.reverse }.concat(kettle_moraine.from_west).concat(kettle_moraine.from_east).uniq}"
