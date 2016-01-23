#include "arith_utils.h"
#include "prime_gen.h"
#include <stdlib.h>
#include <stdio.h>

static int * solve_prime_power_congruence(int degree, int coeffs[], int prime, int power);
static int * solve_system_of_order_1_congruence_sets(int numOfSets, int * lengthsOfSets, int ** sets, int mods[]);

int chinese_remainder_solution(int numberOfEquations, int scals[], int mods[]){
	int i;
	int x = 0;
	int m = mods[0];
	int modCoeff;

	for(i=1; i<numberOfEquations; i++){
		m *= mods[i];
	}

	for(i=0; i<numberOfEquations; i++){
		modCoeff = m/mods[i];
		x += modCoeff*mod_inv(modCoeff, mods[i])*scals[i];
	}

	return x % m;
}


static int * brute_force_congruence(int degree, int coeffs[], int primeMod){
	//assumes a prime modulus. split congruences of composite modulus into systems of congrueneces
	//of prime modulus and/or apply the lifting theorem to make use of this function
	//solve a0x^n + a1x^n-1... = 0 (mod mod) where n is the order a0, a1, ... are coeffieicients
	int * solutionList = calloc(degree+1, sizeof(int));
	int * solutions = solutionList+1;
	int numberOfSolutions = 0;
	int x;

	for(x = 0; x < primeMod && numberOfSolutions <= degree; x++){
		if(mod_eval_polynomial(degree, coeffs, primeMod, x) == 0){
			solutions[numberOfSolutions++] = x;
		}
	}

	*solutionList = numberOfSolutions;

	return solutionList;
}


static int * solve_prime_power_congruence(int funcDegree, int funcCoeffs[], int prime, int power){

	int * baseSolutionList;
	int numOfBaseSolutions;
	int * baseSolutions;

	int * liftedSolutions;
	int numOfLiftedSolutions;

	int derivDegree;
	int * derivCoeffs;
	int deriv;
	long int divFunc;

	int j, t;
	int currentMod;

	if(power == 1){
		return brute_force_congruence(funcDegree, funcCoeffs, prime);
	}

	baseSolutionList = solve_prime_power_congruence(funcDegree, funcCoeffs, prime, power-1);
	numOfBaseSolutions = *baseSolutionList;
	baseSolutions = baseSolutionList+1;

	liftedSolutions = calloc(prime*numOfBaseSolutions+1, sizeof(int));
	numOfLiftedSolutions = 0;

	derivDegree = funcDegree-1;
	derivCoeffs = calloc(derivDegree+1, sizeof(int));

	currentMod = prime;
	for(j = 1; j < power; j++){
		currentMod *= prime;
	}

	for(j = 0; j <= derivDegree; j++){ 
		derivCoeffs[j] = funcCoeffs[j+1]*(j+1);
	}


	for(j = 0; j < numOfBaseSolutions; j++){
		deriv = mod_eval_polynomial(derivDegree, derivCoeffs, prime, baseSolutions[j]);
		divFunc = (eval_polynomial(funcDegree, funcCoeffs, baseSolutions[j]) / (currentMod/prime)) % prime;

		if(deriv % prime != 0){
			t = (-divFunc*mod_inv(deriv, prime) % prime) + prime;
			liftedSolutions[++numOfLiftedSolutions] = baseSolutions[j] + t*prime;
		}

		else if(divFunc % prime == 0){
			for(t = 1; t <= prime; t++){
				liftedSolutions[++numOfLiftedSolutions] = baseSolutions[j] + t*(currentMod/prime);
			}
		}
	}


	*liftedSolutions = numOfLiftedSolutions;

	free(derivCoeffs);
	free(baseSolutionList);

	return liftedSolutions;
}


static int * solve_system_of_order_1_congruence_sets(int numOfSets, int * setLengths, int * * sets, int * mods){
	//allocate perumtation array
	int * divAry = calloc(numOfSets, sizeof(int));
	int * scalAry = calloc(numOfSets, sizeof(int));
	int i, j;
	int numOfSolutions;
	int * solutionAry;
	int * dest;
	int idx;

	for(i = 0, numOfSolutions = 1; i < numOfSets; i++){
		divAry[i] = numOfSolutions;
		numOfSolutions *= setLengths[i];
	}

	solutionAry = calloc(numOfSolutions+1, sizeof(int));
	solutionAry[0] = numOfSolutions;
	dest = solutionAry+1;

	for(i = 0; i < numOfSolutions; i++){
		for(j = 0; j < numOfSets; j++){
			idx = (i / divAry[j]) % setLengths[j];
			scalAry[j] = sets[j][idx];
		}

		*(dest++) = chinese_remainder_solution(numOfSets, scalAry, mods);
	}

	return solutionAry;
}

int * solve_congruence(int funcDegree, int funcCoeffs[], int mod){
	int * solutionList;

	int * modFactorList = prime_factors(mod);
	int numOfModFactors = *modFactorList;
	int * modFactors = modFactorList+1;

	int * * primePowerSolutions = calloc(numOfModFactors, sizeof(int *));
	int * primePowers = calloc(numOfModFactors, sizeof(int));
	int * primePowerSolutionLengths = calloc(numOfModFactors, sizeof(int *));

	int power;
	int i, j;

	for(i = 0; i < numOfModFactors; i++){
		primePowers[i] = modFactors[i]; 
		power = 1;
		
		while(mod % (primePowers[i]*modFactors[i]) == 0){
			primePowers[i] *= modFactors[i];
			power++;
		}

		primePowerSolutions[i] = solve_prime_power_congruence(funcDegree, funcCoeffs, modFactors[i], power);
		primePowerSolutionLengths[i] = *(primePowerSolutions[i]++);
	}


	solutionList = solve_system_of_order_1_congruence_sets(numOfModFactors, primePowerSolutionLengths, primePowerSolutions, primePowers);

	for(i = 0; i < numOfModFactors; i++){
		free(primePowerSolutions[i] - 1);
	}
	free(primePowerSolutionLengths);
	free(primePowerSolutions);
	free(primePowers);
	free(modFactorList);

	return solutionList;
}

/*
int * solve_system_of_congruences(int numOfFuncs, int * funcDegrees, int ** funcCoeffs, int * mods){
	int i;
	int * * funcSolutionSets = calloc(numOfFuncs, sizeof(int *));

	for(i=0; i<numOfFuncs; i++){
		funcSolutionSets[i] = solve_congruence(funcDegrees[i], funcCoeffs[i], mods[i]);
	}

	return solve_system_of_congruence_sets(numOfFuncs, funcSolutionSets, mods);
}	
*/
