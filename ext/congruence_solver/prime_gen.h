#ifndef H_PRIME_GEN
#define H_PRIME_GEN
int * primes(int n);

//Generation of primes is currently time-prohibitive when generating up to large maximums. 
//This should be acceptable for prime factorization because although naive the algorithm is 
//somewhat optimized to detect relatively large prime factors.
int * primes_upto(int max);
int * prime_factors(int n);
#endif