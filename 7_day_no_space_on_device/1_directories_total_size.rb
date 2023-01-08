lines_of_code = File.readlines('sample_input.txt', chomp: true) 
# lines_of_code = File.readlines('input.txt', chomp: true) 

  
class DeviceMemory2
  def initialize
    @lines = File.readlines('sample_input.txt', chomp: true) 
    @directory_history = [:/]
    @file_tree = { "/": { file_sum: 0 } }

    # PLACEHOLDER - working on the sums segment
    # @file_tree = {:/ => {:a => { :e => {:file_sum => 584 }, :file_sum => 94269 }, :d => {:file_sum => 24933642}, :file_sum => 23352670}}
    
    @sums = 0
    # build_file_tree
  end

  # def find_valid_dirs(max_size)
  # end

  def file_tree_sums(hash, sums)
    hash.map do |k, v|
      if v.is_a? Hash
        # puts "k: #{k}; v: #{v}"
        file_tree_sums(v, @sums)
      else
        # puts "hash: #{hash}; sums: #{sums}"
        if v < 100000
          puts "v: #{v}"
          @sums += v
        end
      end
    end
  end

  def file_tree
    @file_tree
  end

  def build_file_tree
    ls_chonks.each do |chonk|
      # puts chonk.to_s 
      parse_chonk(chonk)
      # puts @file_tree
      # puts "---"
    end

    # puts "---"
    @file_tree
    # update_file_sums
  end

  def update_file_sums
    # recursive fun :) 
  end
  
  def parse_chonk(chonk)
    *dir_path, current_dir = @directory_history
    # current_dir = @directory_history.last   # current dir for chonk
    chonk_file_sum = 0                      # sum of chonk's files
    chonk_folders = []                      # list of chonk's folders. needed?


    chonk.map do |line|
      fork_in_the_road, _ = line.split(" ")

      listed_dir = fork_in_the_road == "dir"
      change_dir = fork_in_the_road == "$"
      file = !(change_dir || listed_dir )

      case
      when file                             # get size each file; add to chonk sum
        chonk_file_sum += file_size(line)
      when listed_dir                       # get list of directory (as contents); add to chonk folders
        chonk_folders << dir_name(line)
      when change_dir                       # set directory for the next chonk 
        change_directory(line)    
      end
    end

    update_tree(chonk_folders, chonk_file_sum, current_dir, dir_path)
  end

  def update_tree(dirs, file_size, current_dir, dir_path)
    last_dir, second_last_dir = dir_path.last(2).reverse

    file = { file_sum: file_size }
    
    dirs.each do |d|
      folder = { d.to_sym => { :file_sum => 0 }}

      if @file_tree.member?(second_last_dir)
        @file_tree[second_last_dir][last_dir][current_dir] = folder
      elsif @file_tree.member?(last_dir)
        @file_tree[last_dir][current_dir] = folder
      else
        @file_tree[current_dir] = folder
      end
    end

    if @file_tree.member?(second_last_dir)
      @file_tree[second_last_dir][last_dir][current_dir].merge!(file)
    elsif @file_tree.member?(last_dir)
      @file_tree[last_dir][current_dir].merge!(file)
    else
      @file_tree[current_dir].merge!(file)
    end
  end
  

  def dir_name(dir)
    _, dir_name = dir.split(" ")
    dir_name.to_sym
  end

  def file_name(file)
    _, file_name = file.split(" ")
    file_name.to_sym
  end

  def file_size(file)
    file_size, _ = file.split(" ")
    file_size.to_i
  end

  def change_directory(dir_changes)
      *_, directory = dir_changes.split(" ")

      if directory == ".."
        @directory_history.pop
      else
        @directory_history.push(directory.to_sym)
      end
      @directory_history.last
  end

  def ls_chonks
    @ls_chonks ||= ls_indices.map.with_index do |i, idx|
      j = ( i == ls_indices.last ? -1 : ls_indices[idx + 1] - 1 )
      @lines.slice(i+1..j)
    end
  end

  def ls_indices
    @ls_indicies ||= @lines.map.with_index do |line, i| 
      i if line.match(' ls') 
    end.compact
  end
end

drive = DeviceMemory2.new
# puts drive.change_directory(["584 i", "$ cd ..", "$ cd ..", "$ cd d"])
# drive.parse_chonk(["dir a", "14848514 b.txt", "8504156 c.dat", "dir d", "$ cd a"])
puts drive.build_file_tree
# file_tree = drive.file_tree
# puts drive.file_tree_sums(file_tree, 0).flatten.compact.sum.to_s
