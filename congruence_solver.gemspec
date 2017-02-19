# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'congruence_solver/version'

Gem::Specification.new do |spec|
  spec.name          = "congruence_solver"
  spec.version       = CongruenceSolver::VERSION
  spec.authors       = ["lane"]
  spec.email         = ["lane.barlow@gmail.com"]

  spec.summary       = "A gem for solving polynomial congruences."
  spec.description   = "Provides a class (CongruenceSolver) for finding the modular zeros of a
                          polynomial (given the coefficients and modulus) and a binary (csolve) to
                          to solve your congruences at the command line."
  spec.homepage      = "https://github.com/laneb/congruence_solver"

  spec.files         = `git ls-files`.split("\n")
  spec.files        += `git submodule --quiet foreach pwd`.split("\n").map do |abs_dir|
                          abs_dir = abs_dir.gsub(/^c:/, "C:")
                          dir_in_proj = abs_dir.gsub(/^#{Dir.pwd}\/?/, "")
                          Dir.chdir(abs_dir) do
                            files = `git ls-files`.split("\n")
                            files.map {|fname| "#{dir_in_proj}/#{fname}"}
                          end
                        end.flatten
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.extensions << "ext/congruence_solver/extconf.rb"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake-compiler", "~>0.9"
  spec.add_development_dependency "os", "~>0.9"
end
