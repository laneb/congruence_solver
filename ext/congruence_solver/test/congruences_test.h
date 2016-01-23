#define POL_1_DEGREE 4
#define POL_1_COEFF_0 0
#define POL_1_COEFF_1 9
#define POL_1_COEFF_2 0
#define POL_1_COEFF_3 2
#define POL_1_COEFF_4 1
#define POL_1_MOD 99
#define NUM_OF_POL_1_SOLS 12
#define POL_1_SOL_0 0
#define POL_1_SOL_1 6
#define POL_1_SOL_2 30
#define POL_1_SOL_3 33
#define POL_1_SOL_4 39
#define POL_1_SOL_5 52
#define POL_1_SOL_6 61
#define POL_1_SOL_7 63
#define POL_1_SOL_8 66
#define POL_1_SOL_9 72
#define POL_1_SOL_10 88
#define POL_1_SOL_11 96


#define POL_2_DEGREE 6
#define POL_2_COEFF_0 -1
#define POL_2_COEFF_1 0
#define POL_2_COEFF_2 0
#define POL_2_COEFF_3 0
#define POL_2_COEFF_4 0
#define POL_2_COEFF_5 0
#define POL_2_COEFF_6 1
#define POL_2_MOD 700
#define NUM_OF_POL_2_SOLS 24
#define POL_2_SOL_0 1
#define POL_2_SOL_1 51
#define POL_2_SOL_2 99
#define POL_2_SOL_3 101
#define POL_2_SOL_4 149
#define POL_2_SOL_5 151
#define POL_2_SOL_6 199
#define POL_2_SOL_7 201
#define POL_2_SOL_8 249
#define POL_2_SOL_9 251
#define POL_2_SOL_10 299
#define POL_2_SOL_11 349
#define POL_2_SOL_12 351
#define POL_2_SOL_13 401
#define POL_2_SOL_14 449
#define POL_2_SOL_15 451
#define POL_2_SOL_16 499
#define POL_2_SOL_17 501
#define POL_2_SOL_18 549
#define POL_2_SOL_19 551
#define POL_2_SOL_20 599
#define POL_2_SOL_21 601
#define POL_2_SOL_22 649
#define POL_2_SOL_23 699

#define POL_3_DEGREE 9
#define POL_3_COEFF_0 -11
#define POL_3_COEFF_1 0
#define POL_3_COEFF_2 0
#define POL_3_COEFF_3 3
#define POL_3_COEFF_4 0
#define POL_3_COEFF_5 0
#define POL_3_COEFF_6 0
#define POL_3_COEFF_7 0
#define POL_3_COEFF_8 0
#define POL_3_COEFF_9 10
#define POL_3_MOD 49
#define NUM_OF_POL_3_SOLS 0

#define POL_4_DEGREE 2
#define POL_4_COEFF_0 4
#define POL_4_COEFF_1 -4
#define POL_4_COEFF_2 1
#define POL_4_MOD 5104
#define NUM_OF_POL_4_SOLS 4
#define POL_4_SOL_0 2
#define POL_4_SOL_1 1278
#define POL_4_SOL_2 2554
#define POL_4_SOL_3 3830


int POL_1_COEFFS[POL_1_DEGREE+1] = {POL_1_COEFF_0, 
									POL_1_COEFF_1, 
									POL_1_COEFF_2, 
									POL_1_COEFF_3, 
									POL_1_COEFF_4};
int POL_1_SOLS[NUM_OF_POL_1_SOLS] = {POL_1_SOL_0, 
									 POL_1_SOL_1, 
									 POL_1_SOL_2, 
									 POL_1_SOL_3, 
									 POL_1_SOL_4, 
									 POL_1_SOL_5, 
									 POL_1_SOL_6, 
									 POL_1_SOL_7, 
									 POL_1_SOL_8, 
									 POL_1_SOL_9, 
									 POL_1_SOL_10, 
									 POL_1_SOL_11};

int POL_2_COEFFS[POL_2_DEGREE+1] = {POL_2_COEFF_0, 
									POL_2_COEFF_1, 
									POL_2_COEFF_2, 
									POL_2_COEFF_3, 
									POL_2_COEFF_4, 
									POL_2_COEFF_5, 
									POL_2_COEFF_6};

int POL_2_SOLS[NUM_OF_POL_2_SOLS] = {POL_2_SOL_0, 
								  	 POL_2_SOL_1, 
								  	 POL_2_SOL_2, 
								  	 POL_2_SOL_3, 
								  	 POL_2_SOL_4, 
								  	 POL_2_SOL_5, 
								  	 POL_2_SOL_6, 
								  	 POL_2_SOL_7, 
									 POL_2_SOL_8, 
									 POL_2_SOL_9, 
									 POL_2_SOL_10, 
									 POL_2_SOL_11, 
									 POL_2_SOL_12, 
									 POL_2_SOL_13, 
									 POL_2_SOL_14, 
									 POL_2_SOL_15, 
									 POL_2_SOL_16, 
									 POL_2_SOL_17, 
									 POL_2_SOL_18, 
									 POL_2_SOL_19, 
									 POL_2_SOL_20, 
									 POL_2_SOL_21, 
									 POL_2_SOL_22,
									 POL_2_SOL_23};

int POL_3_COEFFS[POL_3_DEGREE+1] = {POL_3_COEFF_0,
									POL_3_COEFF_1,
									POL_3_COEFF_2,
									POL_3_COEFF_3,
									POL_3_COEFF_4,
									POL_3_COEFF_5,
									POL_3_COEFF_6,
									POL_3_COEFF_7,
									POL_3_COEFF_8,
									POL_3_COEFF_9
									};

int * POL_3_SOLS = NULL;

int POL_4_COEFFS[POL_4_DEGREE+1] = {POL_4_COEFF_0,
									POL_4_COEFF_1,
									POL_4_COEFF_2};

int POL_4_SOLS[NUM_OF_POL_4_SOLS] = {POL_4_SOL_0,
									POL_4_SOL_1,
									POL_4_SOL_2,
									POL_4_SOL_3};