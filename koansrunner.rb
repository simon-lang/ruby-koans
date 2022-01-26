#run this to automatically re-run "ruby path_to_enlightenment.rb" on save

ruby_files = Dir.entries(".").select{ |filename| filename[/.rb/] }

mtimes = ruby_files.map { |filename|
  File.stat(filename).mtime
}

ruby_files.each { |filename| puts filename }

files_and_mtimes = ruby_files.zip(mtimes)

puts "Waiting for files to change..."

while true
  Kernel.sleep 1
  files_and_mtimes = files_and_mtimes.map{ |filename, last_modified|

    if(File.stat(filename).mtime > last_modified)
      puts "Dected modification to " + filename
      Kernel.system("ruby path_to_enlightenment.rb")
      last_modified = File.stat(filename).mtime
    end

    [filename, last_modified]
  }
end