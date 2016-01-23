
congruences_test: congruences.c test/congruences_test.c test/congruences_test.h arith_utils.c prime_gen.c
	gcc -g prime_gen.c arith_utils.c congruences.c test/congruences_test.c -o congruences_test

arith_utils_test: arith_utils.c test/arith_utils_test.c test/arith_utils_test.h prime_gen.c
	gcc -g prime_gen.c arith_utils.c test/arith_utils_test.c -o arith_utils_test

prime_gen_test: prime_gen.c test/prime_gen_test.c test/prime_gen_test.h
	gcc -g prime_gen.c test/prime_gen_test.c -o prime_gen_test

test: prime_gen_test arith_utils_test congruences_test
	./prime_gen_test
	./arith_utils_test
	./congruences_test

clean:
	rm -f prime_gen_test.exe arith_utils_test.exe congruences_test.exe
	