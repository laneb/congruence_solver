#require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rake/extensiontask'




=begin
namespace :test do
	desc "Compile and unit test C extensions"
	Rspec::Core::RakeTask.new :c => :compile_c do |t|
		t.rspec_opts = C_SPEC_FILE
	end
end
=end

#exe runs the csolve binary
task :exe do
	require_relative "bin/csolve.rb"
end

#spec runs all RSpec examples
RSpec::Core::RakeTask.new :spec


#fetch_ext wraps a system command to fetch changes to and merge all (1) submodules
#of this repository (the extension lib files). Gem solutions considered
#but no gems are available which are both working and maintained.
task :fetch_c do
	UPDATE_CMD = "git submodule update --remote"
	system UPDATE_CMD
end

#uses task template provided by rake-compiler to run the extension compilation
#workflow. Task name: compile (do not use task name: ext)
Rake::ExtensionTask.new 'congruence_solver' do |ext|
	ext.lib_dir = "lib/congruence_solver"
end


=begin
#executes compile task defined above, then cleans up the tmp directory that
#rake-compiler leaves behind for some reason
task :compile_c => :compile do
	clean_cmd = "rmdir /s tmp"
end
=end

#update_ext fetches (and merges) changes to extension submodule and compiles the extension  
task :update_ext => [:fetch_c, :compile] do end




