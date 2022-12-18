require 'pry-byebug'
lines_of_code = File.read('sample_input.txt').lines 
# lines_of_code = File.read('input.txt').lines 

class DeviceMemory
  def initialize lines_of_code
    @lines_of_code = lines_of_code
  end

  def tree
    tree = {}
    directory_history = ["/"]

    ls_chonk.map.with_index do |listing, i|
      cd = directory_history.last
      tree[cd] = {}  # FIXME doesn't nest

      files = listing.select{ |r| r.match(/[0-9]/)}
      files = files.map do |f|
        _, file_size = f.split.reverse
        file_size.to_i
      end

      tree[cd]["the_files"] = files.map(&:to_i).sum

      listing.each do |ls|

        if ls.match((/\$ cd/))
          dir_pointer = ls[-2]
          if dir_pointer == "."
            directory_history.pop
            cd = directory_history.last
            next
          else
            directory_history.push(dir_pointer)
          end
        end

      end
    end
    tree
  end

  # chonks of ls results (array of subarrays)
  def ls_chonk
    ls_indices.map.with_index do |i, idx|
      j = ( i == ls_indices.last ? -1 : ls_indices[idx + 1] - 1 )
      @lines_of_code.slice(i+1..j)
    end
  end

  def ls_indices
    @lines_of_code.map.with_index do |line, i| 
      i if line.match(' ls') 
    end.compact
  end

end
  

drive = DeviceMemory.new(lines_of_code)
puts drive.tree
