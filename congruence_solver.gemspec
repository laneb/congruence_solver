# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'congruence_solver/version'

Gem::Specification.new do |spec|
  spec.name          = "congruence_solver"
  spec.version       = CongruenceSolver::VERSION
  spec.authors       = ["lane"]
  spec.email         = ["lane.barlow@gmail.com"]

  spec.summary       = %q{A gem for solving polynomial congruences.}
  spec.description   = %q{Provides a class (CongruenceSolver) for finding the modular zeros of a 
                          polynomial (given the coefficients and modulus) and a binary (csolve) to 
                          to solve your congruences at the command line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.extensions << "ext/congruence_solver/extconf.rb"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 2.4"
  spec.add_development_dependency "rake-compiler", "~>0.9"
end
