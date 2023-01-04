lines_of_code = File.readlines('sample_input.txt', chomp: true) 
# lines_of_code = File.readlines('input.txt', chomp: true) 

  
class DeviceMemory2
  def initialize
    @lines = File.readlines('sample_input.txt', chomp: true) 
    @directory_history = [:/]
    @file_tree = { "/": { file_sum: 0 } }
    # @file_tree = { }
    # build_file_tree
  end

  def find_valid_dirs(max_size)

  end

  def build_file_tree
    ls_chonks.each do |chonk|
      # puts chonk.to_s 
      parse_chonk(chonk)
      # puts @file_tree
      # puts "---"
    end

    puts "---"
    puts @file_tree
    # update_file_sums
  end

  def update_file_sums
    # recursive fun :) 
  end
  
  def parse_chonk(chonk)
    current_dir = @directory_history.last   # current dir for chonk
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

    add_directories_to_tree(chonk_folders, current_dir)
    add_files_to_tree(chonk_file_sum, current_dir)
  end

  def add_files_to_tree(sum, current_dir)
    chonker_sum = { file_sum: sum }

    @file_tree[current_dir] = chonker_sum
  end


  def add_directories_to_tree(folders, current_dir)
    # puts folders.to_s unless folders == []

    folders.each do |f|
      folder = { f.to_sym => {} }
      @file_tree[current_dir]= folder 
    end
  end

  def dir_name(dir)
    _, dir_name = dir.split(" ")
    dir_name.to_sym
  end

  def file_name(file)
    file_size, file_name = file.split(" ")
    file_name.to_sym
  end

  def file_size(file)
    file_size, file_name = file.split(" ")
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
drive.build_file_tree
