lines_of_code = File.readlines('sample_input.txt', chomp: true) 
# lines_of_code = File.readlines('input.txt', chomp: true) 

  
class DeviceMemory2
  def initialize
    @lines = File.readlines('sample_input.txt', chomp: true) 
    @directory_history = [:/]
    @file_tree = { "/": { file_sum: 0 } }
    # build_file_tree
  end

  def find_valid_dirs(max_size)

  end

  def build_file_tree
    ls_chonks.each do |chonk|
      puts chonk.to_s
      parse_chonk(chonk)
    end

    puts @file_tree
    # update_file_sums
  end

  def update_file_sums
    # recursive fun :) 
  end
  
  def parse_chonk(chonk)
    chonk.map do |line|
      fork_in_the_road, _ = line.split(" ")
      file_sum = 0
      current_dir = @directory_history.last

      case fork_in_the_road
      when "dir"
        # add_directories_to_tree(line)        




        # dir_name(line) 
      when "$"
        contents = {}
        @file_tree[current_dir] = dir_name(line) => contents
        change_directory(line)
      else  
        @file_tree[current_dir] = {file_name(line) => file_size(line)}
        
      end
    end
  end


  def add_directories_to_tree(line)
    _, dir_name = line.split(" ")
    folder = { dir_name.to_sym =>  { file_sum: 0 } }
    current_dir = @directory_history.last

    @file_tree[current_dir] = folder 
    
    # @file_tree.merge!(folder)
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

  # def add_files_to_tree(file)
  #   # if dir: add new hash to the tree
  #   # if file: add new file total to the tree at cur directory location
  #   file_size, file_name = file.split(" ")

  #   current_dir = @directory_history.last

  #   @file_tree[current_dir][file_name.to_sym] = file_size.to_s

  #   # @file_tree[current_dir] = { file_name.to_sym => file_size.to_i }
  #   # @file_tree[current_dir][file_sum:] += file_size
  #   # access current directory & add sum to value
  # end

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

# drive = DeviceMemory.new(lines_of_code)
# puts drive.ls_chonk.to_s
# puts drive.change_directory(["584 i", "$ cd ..", "$ cd ..", "$ cd d"])

drive = DeviceMemory2.new
# puts drive.change_directory(["584 i", "$ cd ..", "$ cd ..", "$ cd d"])
# drive.parse_chonk(["dir a", "14848514 b.txt", "8504156 c.dat", "dir d", "$ cd a"])
drive.build_file_tree
