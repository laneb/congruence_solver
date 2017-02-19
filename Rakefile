#require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/extensiontask"
require "os"


#exe runs the csolve binary
task :exe do
  $LOAD_PATH << "#{Dir.pwd}/lib/"
  require_relative "bin/csolve.rb"
end

#spec runs all RSpec examples
RSpec::Core::RakeTask.new :spec

#uses task template provided by rake-compiler to run the extension compilation
#workflow. Task name: compile (do not use task name: ext)
Rake::ExtensionTask.new 'congruence_solver' do |ext|
  ext.lib_dir = "lib/congruence_solver"
end

task :bench do
  $LOAD_PATH << "#{Dir.pwd}/lib/"
  Dir.foreach("bench") do |bm_file|
    path = "bench/#{bm_file}"
    if File.file? path and path =~ "_bm.rb^"
      require_relative path
    end
  end
end

#update submodule containing extension.

task :download_ext do
  CONGRUENCES_LIB_URL="https://github.com/laneb/congruences/archive/master.zip"
  EXT_DIR = "ext/congruence_solver"
  `(cd #{EXT_DIR} && wget #{CONGRUENCES_LIB_URL} && unzip master.zip && cp -r congruences-master/* . && rm -rf master.zip congruences-master )`
end


#executes compile task defined above, then cleans up the tmp directory that
#rake-compiler leaves behind for some reason
task :compile_ext => :compile do
  if OS.windows? then
    `rmdir /s /q tmp`
  else
    `rm -rf tmp`
  end
end

task :purge_ext do
  EXT_FILES = `ls ext/congruence_solver`.split("\n").map {|fname| "ext/congruence_solver/" + fname}
  PERM_EXT_FILES = `git ls-files ext/congruence_solver`.split("\n")
  FILES_TO_RM_ARY = EXT_FILES - PERM_EXT_FILES

  file_to_rm_str = FILES_TO_RM_ARY.inject("") {|file_list, file| file_list += file + " "}

  if OS.windows?
    `rm -rf #{file_to_rm_str}`
  else
    `rm -rf #{file_to_rm_str}`
  end
end

task :update_ext => [:purge_ext, :download_ext, :compile_ext]


task :clean do
  FILES_TO_RM_ARY = %w[
    tmp
    congruence_solver-*.gem
    lib/congruence_solver/congruence_solver.so
    ext/congruence_solver/congruences-master
    ext/congruence_solver/master.zip
  ]

  file_to_rm_str = FILES_TO_RM_ARY.inject("") {|file_list, file| file_list += file + " "}

  if OS.windows?
    `rm -rf #{file_to_rm_str}`
  else
    `rm -rf #{file_to_rm_str}`
  end
end


task :build => [:compile_ext] do
  GEMSPEC = "congruence_solver.gemspec"
  `gem build #{GEMSPEC}`
end


task :install => [:clean, :build] do
  dot_gem_files = Dir.entries(Dir.pwd).select {|f| f =~ /congruence_solver\-.*\.gem/}
  if dot_gem_files.empty?
    STDERR.puts "Failed to build gem. Exiting."
  elsif dot_gem_files.length > 1
    STDERR.puts "Error: conflicting .gem files in directory. Exiting."
  else
    `gem install #{dot_gem_files.first}`
  end
end
