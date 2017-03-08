require "mkmf"

EXT_H = %w[
	arith_utils.h
	congruences.h
	prime_gen.h
]

EXT_C = %w[
	arith_utils.c
	congruence_solver.c
	congruences.c
	prime_gen.c
]

omp_opt = arg_config("--openmp")
if omp_opt
	if have_header("omp.h")
		$CFLAGS += " " + omp_opt
		$DLDFLAGS += " " + omp_opt
	else
		raise "OpenMP unsupported by this compiler"
	end
end

create_makefile "congruence_solver/congruence_solver"
