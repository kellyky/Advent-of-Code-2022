# require 'pry-byebug'
lines_of_code = File.readlines('sample_input.txt', chomp: true) 
# lines_of_code = File.readlines('input.txt', chomp: true) 

class DeviceMemory
  @@total_sum = 0

  def initialize lines_of_code
    @lines_of_code = lines_of_code
    @directory_history = ["/"]
  end

  def directories_max(hash)
    # find sum of directories totally no more than 100000
  end

  def tree
    @tree = Hash.new 
      cd = @directory_history.last
      @tree[cd] = {}  

    ls_chonk.map.with_index do |listing, i|
      file_sum = get_file_sum(listing)
      directories = get_directories(listing)

      *path, last = listing
      puts i
      puts path.to_s
      puts last.to_s

      @cd_commands = change_directory(listing)
      # file_sum = @files.map(&:to_i).sum

      directories.each do |folder|
        path.reduce(@tree, :fetch)[last][folder] = Hash.new
      end

      path.reduce(@tree, :fetch)[last]["file_sum"] = file_sum # file_sum

      @cd_commands.each do |command|
        command == "." ? @directory_history.pop : @directory_history.push(command)
      end

    end
    @tree
  end

  def change_directory(arr)
    folders = arr.select do |string|
      string.match('cd')
    end

    folders.map { |folder| folder.split(" ").last }
    folders.each do |folder|
      if folder == ".." 
        @directory_history.pop
      else
        @directory_history.push(folder)
      end
    end
  end

  def get_directories(arr)
    folders = arr.select do |string|
      string.match('dir')
    end

    folders.map { |folder| folder.split(" ").last }
  end

  def get_file_sum(arr)
    files = arr.select do |string|
      string.match(/[0-9]/)
    end

    files = files.map do |f|
      _, file_size = f.split.reverse
      file_size.to_i
    end.sum
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
drive.tree
puts drive.ls_chonk.to_s
# puts drive.change_directory(["584 i", "$ cd ..", "$ cd ..", "$ cd d"])
