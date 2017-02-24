#require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/extensiontask"
require "os"

def verbose_sh_exec(cmd)
  puts cmd
  `#{cmd}`
end

def verbose_rm_files(files_to_rm_ary)
  if OS.windows?
    rm_cmd = "rm /s /q"
  else
    rm_cmd = "rm -rf"
  end

  files_to_rm_ary.each {|fname| verbose_sh_exec "#{rm_cmd} #{fname}"}
end

# runs the csolve binary
task :exe do
  $LOAD_PATH << "#{Dir.pwd}/lib/"
  require_relative "bin/csolve.rb"
end

#spec runs all RSpec examples
RSpec::Core::RakeTask.new :spec

# run the tests shipped the extension
task :ctest => [:compile_ext] do
  verbose_sh_exec "(cd ext/congruence_solver && make test)"
end

task :test => [:ctest, :spec]

# uses task template provided by rake-compiler to run the extension compilation
# workflow
Rake::ExtensionTask.new 'congruence_solver' do |ext|
  ext.lib_dir = "lib/congruence_solver"
end

# runs benchmarks
task :bench do
  $LOAD_PATH << "#{Dir.pwd}/lib/"
  Dir.foreach("bench") do |bm_file|
    path = "bench/#{bm_file}"
    if File.file? path and path =~ "_bm.rb^"
      require_relative path
    end
  end
end

# download source files for the extension
task :download_ext do
  congruences_lib_url="https://github.com/laneb/congruences/archive/master.zip"
  ext_dir = "ext/congruence_solver"
  verbose_sh_exec "(cd #{ext_dir} && wget #{congruences_lib_url} && unzip master.zip && cp -r congruences-master/* . && rm -rf master.zip congruences-master )"
end


# executes compile task defined by RSpec, then cleans up the tmp directory that
# rake-compiler for some reason leaves behind
task :compile_ext => [:compile] do
  verbose_rm_files ["./tmp"]
end

# remove all the source files for the extension
task :purge_ext do
  ext_files = `ls ext/congruence_solver`.split("\n").map {|fname| "ext/congruence_solver/" + fname}
  perm_ext_files = `git ls-files ext/congruence_solver`.split("\n")
  files_to_rm = ext_files - perm_ext_files

  verbose_rm_files files_to_rm
end

task :update_ext => [:purge_ext, :download_ext, :compile_ext]

# remove files generated or left behind by build
task :clean do
  ext_compiled_files = `find ext/congruence_solver/* -not -path "*.[ch]" -not -path *Makefile -not -path *extconf.rb`.split("\n")
  files_to_rm = ext_compiled_files + %w[
    *.gem
    lib/congruence_solver/congruence_solver.*
  ]
  verbose_rm_files files_to_rm
end

# build Ruby gem
task :build => [:compile_ext] do
  gemspec = "congruence_solver.gemspec"
  verbose_sh_exec "gem build #{gemspec}"
end

# install gem locally
task :install => [:clean, :update_ext, :test, :build] do
  dot_gem_files = Dir.entries(Dir.pwd).select {|f| f =~ /congruence_solver\-.*\.gem/}
  if dot_gem_files.empty?
    STDERR.puts "Failed to build gem. Exiting."
  elsif dot_gem_files.length > 1
    STDERR.puts "Error: conflicting .gem files in directory. Exiting."
  else
    verbose_sh_exec "gem install #{dot_gem_files.first}"
  end
end

task :publish => [:clean, :update_ext, :build] do
  cmd = "gem push *.gem"
  p cmd
  system cmd
end
