require 'pry-byebug'
  
class DeviceMemory2
  def initialize
    @lines = File.readlines('sample_input.txt', chomp: true) 
    # @lines = File.readlines('input.txt', chomp: true) 
    @directory_history = [:/]
    @file_tree = { "/": { file_sum: 0 } }

    @sums = 0
    # build_file_tree
  end

  # def find_valid_dirs(max_size)
  # end

  def file_tree_sums(hash, sums)
    hash.map do |k, v|
      if v.is_a? Hash
        file_tree_sums(v, @sums)
      else
        if v < 100000
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
      parse_chonk(chonk)
    end

    @file_tree
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

    add_folders_to_tree(chonk_folders, current_dir, dir_path)
    add_files_to_tree(chonk_file_sum, current_dir, dir_path)
  end

  def add_folders_to_tree(dirs, current_dir, dir_path)
    last_dir, second_last_dir = dir_path.last(2).reverse

    # folders
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
  end

  def add_files_to_tree(file_size, current_dir, dir_path)
    last_dir, second_last_dir = dir_path.last(2).reverse

    file = { file_sum: file_size }

    # files
    if @file_tree.member?(second_last_dir) 
      # @file_tree[second_last_dir][last_dir][current_dir].merge!(file)
      @file_tree[second_last_dir][last_dir][current_dir][:file_sum] = file_size
    elsif @file_tree.member?(last_dir)
      # @file_tree[last_dir][current_dir].merge!(file)
      @file_tree[last_dir][current_dir][:file_sum] = file_size
    else
      # @file_tree[current_dir].merge!(file)
      @file_tree[current_dir][:file_sum] = file_size
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
puts drive.build_file_tree
# puts drive.file_tree_sums(file_tree, 0).flatten.compact.sum.to_s
# puts drive.lines
