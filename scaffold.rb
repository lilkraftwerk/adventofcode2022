
# get day from CLI input
day = 12
dir_path = File.join(__dir__, day.to_s)
puts "Creating dir: #{dir_path}"
Dir.mkdir(dir_path, 0700)

# copy contents of template file to new rb files
file_names = [
    [dir_path, "/", day.to_s, 'a.rb'].join(""),
    [dir_path, "/", day.to_s, 'b.rb'].join(""),
    [dir_path, "/", 'input.txt'].join(""),
    [dir_path, "/", 'test.txt'].join("")
]

file_names.each do |filename|
    puts "Creating: #{filename}"
    File.new(filename, File::CREAT)
end

puts 'Done!'