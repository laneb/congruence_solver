#include <ruby.h>
#include "congruences.h"
#include "arith_utils.h"
#include "prime_gen.h"


VALUE CongruenceSolver = Qnil;

void Init_congruence_solver();
VALUE method_congruence_solver_lift(VALUE self, VALUE funcCoeffs, VALUE mod);
VALUE method_congruence_solver_brute_force(VALUE self, VALUE funcoeffs, VALUE mod);

void Init_congruence_solver(){
  CongruenceSolver = rb_define_module("CongruenceSolver");

  rb_define_singleton_method(CongruenceSolver, "lift",
                             method_congruence_solver_lift, 2);

  rb_define_singleton_method(CongruenceSolver, "brute_force",
                             method_congruence_solver_brute_force, 2);
}


VALUE method_congruence_solver_brute_force(VALUE self, VALUE funcCoeffs, VALUE mod){
  int i;
  long * longSolutions;
  VALUE rbSolutions;
  long longMod = NUM2LONG(mod);

  int intFuncDegree = RARRAY_LEN(funcCoeffs)-1;
  long * longFuncCoeffs = calloc(intFuncDegree+1, sizeof(long));

  for(i = 0; i <= intFuncDegree; i++){
    longFuncCoeffs[i] = NUM2LONG(rb_ary_entry(funcCoeffs, i));
  }

  longSolutions = brute_force_congruence(intFuncDegree, longFuncCoeffs, longMod);
  rbSolutions = rb_ary_new2(longSolutions[0]);

  for(i=0; i<longSolutions[0]; i++){
    rb_ary_store(rbSolutions, i, LONG2NUM(longSolutions[i+1]));
  }


  free(longFuncCoeffs);
  free(longSolutions);

  return rbSolutions;
}


VALUE method_congruence_solver_lift(VALUE self, VALUE funcCoeffs, VALUE mod){
  int i;
  long * longSolutions;
  VALUE rbSolutions;
  long longMod = NUM2LONG(mod);

  int intFuncDegree = RARRAY_LEN(funcCoeffs)-1;
  long * longFuncCoeffs = calloc(intFuncDegree+1, sizeof(long));

  for(i=0; i<=intFuncDegree; i++){
    longFuncCoeffs[i] = NUM2LONG(rb_ary_entry(funcCoeffs, i));
  }

  longSolutions = solve_congruence(intFuncDegree, longFuncCoeffs, longMod);

  rbSolutions = rb_ary_new2(longSolutions[0]);

  for(i=0; i<longSolutions[0]; i++){
    rb_ary_store(rbSolutions, i, LONG2NUM(longSolutions[i+1]));
  }


  free(longFuncCoeffs);
  free(longSolutions);

  return rbSolutions;
}
