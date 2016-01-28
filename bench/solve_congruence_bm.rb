require "congruence_solver"
require "benchmark"


SMALL_DEG_POLYNOMIAL_COEFFS = [1, -4, 4] 
LARGE_DEG_POLYNOMIAL_COEFFS = [-11, 0, 0, 3, 0, 0, 0, 0, 0, 10]
SMALL_MOD = 49
MED_MOD = 5104
LARGE_MOD = 94122
XTRA_LARGE_MOD = 214092
SMALL_FACTORED_LARGE_MOD = 510510


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


def bm_solve_congruence(coeffs, mod) 
		puts "Solving #{polynomial_to_s(coeffs)} = 0 mod #{mod}"

		rb_bf_solutions = solve_congruence_brute_force(coeffs, mod).sort
		c_bf_solutions = CongruenceSolver.brute_force(coeffs, mod).sort
		c_lifting_solutions = CongruenceSolver.lift(coeffs, mod).sort

		unless rb_bf_solutions == c_bf_solutions and c_bf_solutions == c_lifting_solutions
			puts "Solutions do not match:"
			puts "Ruby/force solutions #{rb_bf_solutions.inspect}"
			puts "C/force solutions #{c_bf_solutions}"
			puts "C/lifting solutions: #{c_lifting_solutions.inspect}"
		end

		puts "Time measurements:"

		Benchmark.bmbm do |bm|
			bm.report("Ruby/force") do
				solve_congruence_brute_force(coeffs, mod)
			end

			bm.report("C/force") do
				CongruenceSolver.brute_force(coeffs, mod)
			end

			bm.report("C/lifting") do
				CongruenceSolver.lift(coeffs, mod)
			end
		end

		print "\n\n"
end


[SMALL_DEG_POLYNOMIAL_COEFFS, LARGE_DEG_POLYNOMIAL_COEFFS].each do |coeffs|
	[SMALL_MOD, MED_MOD, LARGE_MOD, XTRA_LARGE_MOD, SMALL_FACTORED_LARGE_MOD].each do |mod|
		bm_solve_congruence(coeffs, mod)
	end
end