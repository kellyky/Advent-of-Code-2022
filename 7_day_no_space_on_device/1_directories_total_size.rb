# require 'pry-byebug'
lines_of_code = File.readlines('sample_input.txt', chomp: true) 
# lines_of_code = File.readlines('input.txt', chomp: true) 

# class DeviceMemory
#   @@total_sum = 0

#   def initialize lines_of_code
#     @lines_of_code = lines_of_code
#     @directory_history = ["/"]
#   end

#   def directories_max(hash)
#     # find sum of directories totally no more than 100000
#   end

#   def tree
#     @tree = Hash.new 
#       cd = @directory_history.last
#       @tree[cd] = {}  

#     ls_chonk.map.with_index do |listing, i|
#       file_sum = get_file_sum(listing)
#       directories = get_directories(listing)

#       *path, last = listing
#       puts i
#       puts path.to_s
#       puts last.to_s



#     end
#     @tree
#   end

#   def change_directory(arr)
#     folders = arr.select do |string|
#       string.match('cd')
#     end

#     folders.map { |folder| folder.split(" ").last }
#     folders.each do |folder|
#       if folder == ".." 
#         @directory_history.pop
#       else
#         @directory_history.push(folder)
#       end
#     end
#   end

#   def get_directories(arr)
#     folders = arr.select do |string|
#       string.match('dir')
#     end

#     folders.map { |folder| folder.split(" ").last }
#   end

#   def get_file_sum(arr)
#     files = arr.select do |string|
#       string.match(/[0-9]/)
#     end

#     files = files.map do |f|
#       _, file_size = f.split.reverse
#       file_size.to_i
#     end.sum
#   end

#   # chonks of ls results (array of subarrays)
#   def ls_chonk
#     ls_indices.map.with_index do |i, idx|
#       j = ( i == ls_indices.last ? -1 : ls_indices[idx + 1] - 1 )
#       @lines_of_code.slice(i+1..j)
#     end
#   end

#   def ls_indices
#     @ls_indicies ||= @lines_of_code.map.with_index do |line, i| 
#       i if line.match(' ls') 
#     end.compact
#   end

# end
  
class DeviceMemory2
  def initialize
    @lines = File.readlines('sample_input.txt', chomp: true) 
    @directory_history = []
    @file_tree = { "/": { file_sum: 0 } }
    build_file_tree
  end

  def find_valid_dirs(max_size)

  end

  def build_file_tree
    ls_chonks.each do |chonk|
      puts chonk.to_s
      parse_chonk(chonk)
      parse_chonk(chonk)
    end

    update_file_sums
  end

  def update_file_sums
    # recursive fun :) 
  end
  
  def parse_chonk(chonk)
    #  find the first item in the array with a "cd" command
    #  files = items before that
    #  dir_changes = items after that
    add_files_to_tree(files)
    change_directory(dir_changes)
  end

  def add_files_to_tree(files)
    # if dir: add new hash to the tree
    # if file: add new file total to the tree at cur directory location
  end

  def change_directory(dir_changes)
    # if cd .., dir.pop / else dir.push(cd.split(" ").last)
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
# drive.tree
# puts drive.ls_chonk.to_s
# puts drive.change_directory(["584 i", "$ cd ..", "$ cd ..", "$ cd d"])

drive = DeviceMemory2.new
