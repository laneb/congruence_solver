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

create_makefile "congruence_solver/congruence_solver"