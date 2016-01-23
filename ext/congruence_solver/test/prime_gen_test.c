#include <stdio.h>
#include "../prime_gen.h"
#include "prime_gen_test.h"



int main(){
  int failures = 0;
  int i;
  int * prime_ary_to_test = primes_upto(MAX_PRIME_FOR_PRIMES_UPTO_TEST)+1;

  for(i=0; PRIME_ARY[i] <= MAX_PRIME_FOR_PRIMES_UPTO_TEST; i++){
    if(PRIME_ARY[i] != prime_ary_to_test[i]){
      printf("%dth prime incorrect: %d given instead of %d.\n\n", i, prime_ary_to_test[i], PRIME_ARY[i]);
      failures += 1;
    }
  }

  printf("Primes up to %d generated without error.\n\n", MAX_PRIME_FOR_PRIMES_UPTO_TEST);

  prime_ary_to_test = primes(LIST_LENGTH_FOR_PRIMES_TEST);

  for(i = 0; i < LIST_LENGTH_FOR_PRIMES_TEST; i++){
    if(PRIME_ARY[i] != prime_ary_to_test[i]){
      printf("%dth prime incorrect: %d given instead of %d.\n\n", i, prime_ary_to_test[i], PRIME_ARY[i]);
      failures += 1;
    }
  }

  printf("First %d primes generated without error.\n\n", LIST_LENGTH_FOR_PRIMES_TEST);
 
  //Due to the implementation of prime generation and calculation of a maximum divisor
  //2 (and 3, for the same reason) arises as a corner case
  failures += prime_factors_test(2, FACTORS_OF_2, 1);

  //Factorization of a prime should return an array containig a 1 followed by the prime itself.
  failures += prime_factors_test(PRIME_TO_FACTOR, FACTORS_OF_PRIME, 1);

  //Factorization of a  composite should return an array containing the number of factors and the 
  //followed by the factors. 
  failures += prime_factors_test(SMALL_COMPOSITE, FACTORS_OF_SMALL_COMPOSITE, NUM_OF_SMALL_COMPOSITE_FACTORS);

  //Factorization of composites with factors to powers greater than 1 should still only list each factor once.
  failures += prime_factors_test(COMPOSITE_WITH_REPEATED_FACTORS, REPEATED_FACTORS, NUM_OF_REPEATED_FACTORS); 

  //Original implementation ran took several minutes to generate the primes necessary
  //to factor large numbers.
  printf("Beginning to factor a large composite number (%d). A stall here would indicate slow execution.\n",
          LARGE_COMPOSITE);
  failures += prime_factors_test(LARGE_COMPOSITE, FACTORS_OF_LARGE_COMPOSITE, NUM_OF_LARGE_COMPOSITE_FACTORS);

  //Optimized implementation leverages the least prime factor (once discovered) to minimize the amount of prime generation necessary
  //This method will still falter somewhat when the smallest prime factors are large.
  printf("Beginning to factor a composite with no small prime factors (%d). A stall here would indicate slow execution.\n",
          COMPOSITE_WITH_LARGE_FACTORS);
  failures += prime_factors_test(COMPOSITE_WITH_LARGE_FACTORS, LARGE_FACTORS, NUM_OF_LARGE_FACTORS);

  return failures;
}


int prime_factors_test(int num, int * expected_factors, int num_of_expected_factors){
  int * factor_list = prime_factors(num);
  int i;

  if(factor_list[0] != num_of_expected_factors){
    printf("Incorrect factorization of prime %d: %d factors given instead of %d.\n\n", num, factor_list[0], num_of_expected_factors);
    return 1;
  }

  else{
    for(i = 0; i < num_of_expected_factors; i++){
      if(factor_list[i+1] != expected_factors[i]){
        printf("Incorrect 0th factor of %d: %d given.\n\b", num, factor_list[1]);
        return 1;
      }
    }
  }

  printf("%d factored correctly.\n\n", num);

  return 0;
}