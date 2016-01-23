#!/usr/bin/env ruby
require 'congruence_solver'
require_relative "csolve/interpret.rb"


coeffs, mod = std_congruence(gets)

CongruenceSolver.solve_congruence

=begin
coeffs.zip(exponents).inject(String.new) do |coeff, exp, str| 
	str += "#{coeff}x"
	str += "\^#{exp}" unless(exp.nil?)
end
=end