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


#executes compile task defined above, then cleans up the tmp directory that
#rake-compiler leaves behind for some reason
task :compile_c => :compile do
	CLEAN_CMD = "rmdir /s /q tmp"
	system CLEAN_CMD
end






