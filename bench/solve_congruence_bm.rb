require "congruence_solver"
require "benchmark"

def solve_congruence_brute_force(coeffs, mod)
	solutions = []

	0.upto(mod) do |x|
		sum = 0

		coeffs.each_with_index do |coe, exp|
			sum = (sum + coe*x**exp) % mod
		end

		if sum == 0 then solutions << x end
	end

	solutions
end

SMALL_DEG_POLYNOMIAL_COEFFS = [1, -4, 4] 
LARGE_DEG_POLYNOMIAL_COEFFS = [-11, 0, 0, 3, 0, 0, 0, 0, 0, 10]
SMALL_PRIME_MOD = 49
MED_PRIME_MOD = 5104
LARGE_PRIME_MOD = 94122

[SMALL_DEG_POLYNOMIAL_COEFFS, LARGE_DEG_POLYNOMIAL_COEFFS].each do |coeffs|
	[SMALL_PRIME_MOD, MED_PRIME_MOD, LARGE_PRIME_MOD].each do |mod|
		polynomial = ""
		is_first_term = true

		coeffs.reverse.each_with_index do |coe, idx|
			exp = coeffs.length - idx - 1
			if coe != 0
				if is_first_term
					is_first_term = false
				else
					if coe < 0
						polynomial << " - "
					else
						polynomial << " + "
					end
				end

				if coe.abs > 1
					polynomial << coe.abs.to_s
				end

				if exp > 0
					polynomial << "x"
					if exp > 1
						polynomial << "^#{exp}"
					end
				end
			end
		end

		puts "Solving #{polynomial} = 0 mod #{mod}"

		bf_solutions = solve_congruence_brute_force(coeffs, mod).sort
		c_solutions = CongruenceSolver.solve_congruence(coeffs, mod).sort

		if bf_solutions != c_solutions
			puts "Solutions of brute force method (Ruby) and lifting method (C) don't match."
		end

		puts "Time measurements:"

		Benchmark.bmbm do |bm|
			rb_time = bm.report("Ruby/force") do
				solve_congruence_brute_force(coeffs, mod)
			end

			c_time = bm.report("C/lifting") do
				CongruenceSolver.solve_congruence(coeffs, mod)
			end
		end

		print "\n\n"
	end
end