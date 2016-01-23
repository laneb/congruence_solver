#!/usr/bin/env ruby
require 'congruence_solver'
require_relative "csolve/interpret"

puts "Congruence to solve:"

coeffs, mod = PolynomialInterpreter.read_congruence(STDIN.gets)

solutions = CongruenceSolver.solve_congruence(coeffs, mod).sort

if solutions.empty? 
	puts "No solution."
else
	puts "Solutions:"
	solutions.each_with_index {|sol, i| puts "(#{i}) #{sol}"}
end