#include <stdio.h>
#include "../arith_utils.h"
#include "arith_utils_test.h"

int main(){
	int failures = 0;
	int i;

	for(i = 0; i < NUM_OF_MOD_INV_TESTS; i++){
		failures += mod_inv_test(MOD_INV_NUMS[i], MOD_INV_MODS[i], MOD_INV_INVS[i]);
	}
	
	for(i = 0; i < NUM_OF_MOD_PRODUCT_TESTS; i++){
		failures += mod_product_test(MOD_PRODUCT_NUM_PAIRS[i], MOD_PRODUCT_MODS[i], MOD_PRODUCT_PRODUCTS[i]);
	}

	for(i = 0; i < NUM_OF_MOD_POWER_TESTS; i++){
		failures += mod_power_test(MOD_POWER_NUMS[i], MOD_POWER_MODS[i], MOD_POWER_POWERS[i], MOD_POWER_EVALS[i]);
	}
	
	for(i = 0; i < NUM_OF_COPRIME_TESTS; i++){
		failures += coprime_test(COPRIME_NUM_PAIRS[i], COPRIME_EVALS[i]);
	}

	for(i = 0; i < NUM_OF_TOTIENT_TESTS; i++){
		failures += totient_test(TOTIENT_NUMS[i], TOTIENT_EVALS[i]);
	}

	printf("%d functions failing in arith_utils.c\n\n", failures);
	return failures;
}


int totient_test(int num, int tot){ 
	int eval_totient = totient(num);

	if(tot != eval_totient){
		printf("Totient of %d incorrectly evaluated: %d given instead of %d.\n", 
				num, eval_totient, tot);
		return 1;
	}

	else{
		return 0;
	}
}


int coprime_test(int * pair, int isCoprime){
	int evalCoprime = coprime(pair[0], pair[1]);

	if(isCoprime && !evalCoprime){
		printf("%d and %d incorrectly evaluated as not coprime.\n", 
				pair[0], pair[1]);
		return 1;
	}

	else if(!isCoprime && evalCoprime){
		printf("%d and %d incorrectly evaluated as coprime.\n",
				pair[0], pair[1]);
		return 1;
	}

	else{
		return 0;
	}
}


int mod_power_test(int num, int mod, int pwr, int mdpwr){
	int mdpwrEval = mod_power(num, pwr, mod);

	if(mdpwrEval != mdpwr){
		printf("Incorrect evaluation of %d^%d mod %d: %d instead of %d.\n", 
				num, pwr, mod, mdpwrEval, mdpwr);
		return 1;
	}

	return 0;
}


int mod_product_test(int * pair, int mod, int product){
	int prod = mod_product(pair[0], pair[1], mod);

	if(prod != product){
		printf("Incorrect evaluation of %d*%d mod %d: %d instead of %d.\n", 
				pair[0], pair[1], mod, prod, product);
		return 1;
	}

	return 0;
}


int mod_inv_test(int num, int mod, int inv){
	int invEval = mod_inv(num, mod);
	
	if(inv != invEval){
		printf("Incorrect evaluation of %d^-1 mod %d: %d instead of %d.\n", num, mod, invEval, inv);
		return 1;
	}

	return 0;
}

