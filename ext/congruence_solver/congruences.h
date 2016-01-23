#ifndef H_CONGRUENCES
#define H_CONGRUENCES
int chinese_remainder_solution(int numOfEquations, int scals[], int mods[]);
int * solve_congruence(int funcDegree, int funcCoeffs[], int mod);
//int * solve_system_of_congruences(int numOfFuncs, int * funcDegrees, int ** funcCoeffs, int * mods);
#endif