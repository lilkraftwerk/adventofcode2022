require "fileutils"

# get day from CLI input
puts "Enter the day: "
day = gets.chomp.to_i

dir_path = File.join(__dir__, day.to_s)
template = File.join(__dir__, "template.rb")
current_dir = File.join(__dir__)

puts "Creating dir: #{dir_path}"
Dir.mkdir(dir_path, 0700)

# copy contents of template file to new rb files

code_file_path = [dir_path, "/", day.to_s, "a.rb"].join("")

file_names = [
  code_file_path,
  [dir_path, "/", "input.txt"].join(""),
  [dir_path, "/", "test.txt"].join("")
]

file_names.each do |filename|
  puts "Creating: #{filename}"
  File.new(filename, File::CREAT)
end

FileUtils.cp(template, code_file_path)

puts "Done!"
