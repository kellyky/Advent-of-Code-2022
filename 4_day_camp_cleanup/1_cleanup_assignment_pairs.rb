assignment_pairs = File.read("input.txt").split

class Cleanup
  def initialize(assignment_pairs)
    @assignment_pairs = assignment_pairs
  end

  def count_overlapping_assignments
    find_overlapping_assignments.select{|el| el == true }.count
  end

  def find_overlapping_assignments
    integer_quartets.map do |quartet|
      a, b, c, d = quartet
      (a >= c && b <= d) || (a <= c && b >= d)
    end
  end

  def integer_quartets
    @assignment_pairs.map do |pair|
       pair.split(/,|-/).map(&:to_i)
    end
  end

end

assignment_pairs = Cleanup.new(assignment_pairs)
puts assignment_pairs.count_overlapping_assignments
