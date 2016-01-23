
int least_primitive_root(int n);
int * primitive_roots(int n);
int has_primitive_root(int n);

int isPrimRoot(int g, int mod){
	int tot = totient(mod);
	int * totFactorList = prime_factors(tot);
	int numOfTotFactors = *totFactorList;
	int * totFactors = totFactorList+1;
	int i;

	for(i=0; i<numOfTotFactors; i++){
		if(mod_power(g, tot/totFactors[i], mod) == 1){
			return 0;
		}
	}

	free(totFactorList);

	return 1;
}


int has_primitive_root(int n){
	int * factorList = prime_factors(n);
	int numOfFactors = *factorList;
	int * factors = factorList+1;
	int has = 1;

	if(numOfFactors > 2 || n % 8 == 0 || (numOfFactors == 2 && factors[0] == 2 && n % 4 ==0)){
		has = 0;
	}

	free(factorList);

	return has;
}


int least_primitive_root(int n){
	int g;

	if(has_primitive_root(n)){
		for(g=2; g<n; g++){
			if(isPrimRoot(g, n)){
				return g;
			}
		}
	}

	return 0;
}


int * primitive_roots(int n){
	int g = least_primitive_root(n);
	int rootCount;
	int * rootList = NULL;
	int * roots;
	int tot;
	int power;

	if(g != 0){
		tot = totient(n);
		rootCount = totient(tot);
		rootList = calloc(rootCount + 1, sizeof(int));
		*rootList = rootCount;
		roots = rootList+1;
		*(roots++) = g;

		for(power=2; power < n; power++){
			if( coprime(tot, power) ){
				*(roots++) = mod_power(g, power, n);
			}
		}
	}

	return rootList;
}


int * prime_factors(int n){
	int divMax = (int) n;
	int * primeList = primes_upto( divMax );
	int numberOfPrimes = primeList[0];
	int * primes = primeList + 1;

	int * divisorList = (int *) calloc(numberOfPrimes+1, sizeof(int *));
	int * divisors = divisorList+1;
	int divListLength = 0;

	int i;

	for(i = 0; i < numberOfPrimes; i++){
		if(n % primes[i] == 0){
			divisors[divListLength++] = primes[i];
		}
	}


	if(divListLength == 0){
		divisors[0] = n;
		divListLength = 1;
	}

	divisorList[0] = divListLength;

	free(primeList);

	return divisorList;
}
