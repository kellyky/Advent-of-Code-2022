lines_of_code = File.read('sample_input.txt').lines 
# lines_of_code = File.read('input.txt').lines 

class DeviceMemory
  def initialize lines_of_code
    @lines_of_code = lines_of_code
  end

  def ls_indices
    @lines_of_code.map.with_index do |line, i| 
      i if line.match(' ls') 
    end.compact
  end

  # chonks of ls results (array of subarrays)
  def ls_results
    ls_indices.map.with_index do |i, idx|
      j = ( i == ls_indices.last ? -1 : ls_indices[idx + 1] - 1 )
      @lines_of_code.slice(i+1..j)
    end
  end

  def file_tree
    tree = {}
    
    current_dir = ["/"]
    tree["/"] = {}

    ls_results.each.with_index do |listing, i|
      cd_to = i == 0 ? "/" : listing.last.split.last
      if i == 0 #|| i == 1
        # puts listed files in tree 
        files = listing.select{ |r| r.match(/[0-9]/)}
        files.each do |f|
          file_name, file_size = f.split.reverse
          file_name
          file_size.to_i
          tree[current_dir.last][file_name] = file_size.to_i
        end

        # puts listed directory in tree
        dirs_in_this_listing = listing.select{ |r| r.match('dir') }.map{ |dir| dir.split.last }
        dirs_in_this_listing.each do |dir|
          tree[current_dir.last][dir] = {}
        end

        cd_to = listing.last.split.last
        # attempt to change directory


        # unless listing.last.split.last == "."
        #   current_dir = listing.last.split.last

        # else
        #   # handle going up a directory
        #   current_dir.pop
        #   next
        # end

      end



    end


    # tree[current_dir.last] = directories_listed
    
    # dirs_directed = cd_directions.map do |d|
    #   pointer = current_dir.last
    #   if d == "."
    #     current_dir.pop
    #     next
    #   else
    #     tree[pointer] = directories_listed
    #     current_dir.push(d)
    #   end
    # end 


    tree
  end

  def cd_directions
    @lines_of_code
      .select{ |line| line.match('cd') }
      .map{ |command| command[-2] }
  end

end
  

drive = DeviceMemory.new(lines_of_code)
puts drive.file_tree
