require "congruence_solver"
require "benchmark"
require_relative "./bench_tools.rb"

COEFFS = [-11, 0, 1, 3, 0, 5, 4, 180, 0, 10]
COMPOSITE_MOD = 4837012493
PRIME_MOD = 57081391

def bm_solve_congruence(coeffs, mod)
    puts "Solving #{polynomial_to_s(coeffs)} = 0 mod #{mod}"
    puts "Measurements:"
    Benchmark.bmbm do |bm|
      bm.report("C/lifting") do
        CongruenceSolver.lift(coeffs, mod)
      end
    end
    print "\n\n"
end

bm_solve_congruence(COEFFS,COMPOSITE_MOD)
bm_solve_congruence(COEFFS,PRIME_MOD)
