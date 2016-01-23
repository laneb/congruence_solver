#include <ruby.h>
#include "congruences.h"
#include "arith_utils.h"
#include "prime_gen.h"


VALUE CongruenceSolver = Qnil;

void Init_congruence_solver();
VALUE method_congruence_solver_solve_congruence(VALUE self, VALUE funcCoeffs, VALUE mod);
//VALUE method_congruence_solver_solve_system_of_congruences(VALUE self, VALUE funcDegreeAry, VALUE aryOfFuncCoeffArys, VALUE modAry);


void Init_congruence_solver(){
	CongruenceSolver = rb_define_module("CongruenceSolver");
	
	rb_define_singleton_method(CongruenceSolver, "solve_congruence",
								method_congruence_solver_solve_congruence, 2);

	/*rb_define_singleton_method(CongruenceSolver, "solve_system_of_congruences", 
								method_congruence_solver_solve_system_of_congruence, 3);
	*/
}
 

VALUE method_congruence_solver_solve_congruence(VALUE self, VALUE funcCoeffs, VALUE mod){
	int i;
	int * intSolutions;
	VALUE rbSolutions;
	int intMod = NUM2INT(mod);

	int intFuncDegree = RARRAY_LEN(funcCoeffs)-1;
	int * intFuncCoeffs = calloc(intFuncDegree+1, sizeof(int));

	for(i=0; i<=intFuncDegree; i++){
		intFuncCoeffs[i] = NUM2INT(rb_ary_entry(funcCoeffs, i));
	}


	intSolutions = solve_congruence(intFuncDegree, intFuncCoeffs, intMod);
	rbSolutions = rb_ary_new2(intSolutions[0]);

	for(i=0; i<intSolutions[0]; i++){
		rb_ary_store(rbSolutions, i, INT2NUM(intSolutions[i+1]));
	}


	free(intFuncCoeffs);
	free(intSolutions);

	return rbSolutions;
}

