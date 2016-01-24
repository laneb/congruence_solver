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
SMALL_MOD = 49
MED_MOD = 5104
LARGE_MOD = 94122
XTRA_LARGE_MOD = 214092
SMALL_FACTORED_LARGE_MOD = 510510

[SMALL_DEG_POLYNOMIAL_COEFFS, LARGE_DEG_POLYNOMIAL_COEFFS].each do |coeffs|
	[SMALL_MOD, MED_MOD, LARGE_MOD, XTRA_LARGE_MOD, SMALL_FACTORED_LARGE_MOD].each do |mod|
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

				if coe.abs > 1 or coe.abs == 1 and exp < 2
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

		rb_bf_solutions = solve_congruence_brute_force(coeffs, mod).sort
		c_bf_solutions = CongruenceSolver.brute_force(coeffs, mod).sort
		c_lifting_solutions = CongruenceSolver.lift(coeffs, mod).sort

		if rb_bf_solutions != c_bf_solutions
			puts "Solutions of brute force method (Ruby) and brute force method (C) don't match."
		end

		if c_bf_solutions != c_lifting_solutions
			puts "Solutions of brute force method (C) and lifting method (C) don't match."
		end

		puts "Time measurements:"

		Benchmark.bmbm do |bm|
			bm.report("Ruby/force (x1)") do
				solve_congruence_brute_force(coeffs, mod)
			end

			bm.report("C/force (x1000)") do
				1000.times {CongruenceSolver.brute_force(coeffs, mod)}
			end

			bm.report("C/lifting (x1000)") do
				1000.times {CongruenceSolver.lift(coeffs, mod)}
			end
		end

		print "\n\n"
	end
end