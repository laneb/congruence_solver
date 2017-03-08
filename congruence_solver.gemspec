# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'congruence_solver/version'

Gem::Specification.new do |spec|
  spec.name          = "congruence_solver"
  spec.version       = CongruenceSolver::VERSION
  spec.license       = "Apache-2.0"
  spec.authors       = ["lane"]
  spec.email         = ["lane.barlow@gmail.com"]

  spec.summary       = "A gem for solving polynomial congruences."
  spec.description   = "Provides a class (CongruenceSolver) for finding the modular zeros of a
                          polynomial (given the coefficients and modulus) and a binary (csolve) to
                          to solve your congruences at the command line."
  spec.homepage      = "https://github.com/laneb/congruence_solver"

  spec.files         = `git ls-files`.split("\n")
  spec.files        += `(ls ext/congruence_solver)`.split("\n").map { |fname| "ext/congruence_solver/" + fname}
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.extensions << "ext/congruence_solver/extconf.rb"

  spec.add_development_dependency "bundler", "~>1.10"
  spec.add_development_dependency "rake", "~>10.0"
  spec.add_development_dependency "rspec", "~>3.0"
  spec.add_development_dependency "rake-compiler", "~>0.9"
  spec.add_development_dependency "os", "~>0.9"
end
