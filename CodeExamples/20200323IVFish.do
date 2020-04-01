clear all
/*
ssc install estout
*/
scuse fish

describe

generate lQ = log(quantity)
label variable lQ "log quantity"


generate lP = log(price)
label variable lP "log price"

set scheme s2mono

//twoway (scatter lP lQ)

eststo col1: regress lQ lP
	estadd local Model "OLS"

// ivregress estimator depvar varlist1 (varlist2 = varlistiv) if   in  weight 

eststo col2: ivregress 2sls lQ (lP = speed2 wave2)
	estadd local Model "IV"



esttab , se scalars(Model) label

esttab using fish.rtf, se scalars(Model) replace label
