#!/usr/bin/env ruby
require 'congruence_solver'
require "polynomial_interpreter"

CONGRUENCE_FORMAT = "(lhs polynomial) = (rhs polynomial) mod (modulus)"
CONGRUENCE_INVALID_MSG = "Congruence invalid: congruences must be of form:\n#{CONGRUENCE_FORMAT}"
POLYNOMIAL_FORMAT = "ax^b+cx^d...\n(integer coefficients, positive integer exponents, order irrelevant)"
LHS_INVALID_MSG = "Left hand polynomial invalid: polynomials must be of form: #{POLYNOMIAL_FORMAT}"
RHS_INVALID_MSG = "Right hand polynomial invalid: polynomials must be of form: #{POLYNOMIAL_FORMAT}"
MOD_INVALID_MSG = "Mod invalid: modulus must be an integer greater than 2"

puts "Congruence to solve:"

begin
	coeffs, mod = PolynomialInterpreter.read_congruence(STDIN.gets)
rescue ArgumentError => e
	if(e == PolynomialInterpreter::Errors::CONGRUENCE_INVALID)
		STDERR.puts CONGRUENCE_INVALID_MSG
		exit(1)

	elsif(e == PolynomialInterpreter::Errors::LHS_POLYNOMIAL_INVALID)
		STDERR.puts LHS_INVALID_MSG
		exit(1)

	elsif(e == PolynomialInterpreter::Errors::RHS_POLYNOMIAL_INVALID)
		STDERR.puts RHS_INVALID_MSG
		exit(1)

	elsif(e == PolynomialInterpreter::Errors::MOD_INVALID)
		STDERR.puts MOD_INVALID_MSG
		exit(1)

	else
		raise e
	end
end

solutions = CongruenceSolver.lift(coeffs, mod).sort

if solutions.empty? 
	puts "No solution."
else
	puts "Solutions:"
	solutions.each_with_index {|sol, i| puts "(#{i}) #{sol}"}
end