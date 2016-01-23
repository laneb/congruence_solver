#ifndef H_ARITH_UTILS
#define H_ARITH_UTILS
int mod_inv(int n, int mod);
int mod_product(int n1, int n2, int mod);
int mod_power(int n, int power, int mod);
int mod_eval_polynomial(int degree, int coeffs[], int mod, int x);
long eval_polynomial(int degree, int coeffs[], int x);
int coprime(int n1, int n2);
int totient(int n);
#endif