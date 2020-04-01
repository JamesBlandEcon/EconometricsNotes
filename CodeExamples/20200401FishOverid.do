clear all

/*Go to: http://www.scunning.com/mixtape.html
to install scuse.ado
*/

/*
ssc install estout
*/
scuse fish

generate lQ = log(quantity)
label variable lQ "log quantity"


generate lP = log(price)
label variable lP "log price"

describe

eststo col_1: ivregress 2sls lQ (lP = speed2 wave2)
	estadd local speed "Y"
	estadd local height "Y"
	estat overid
	estadd local overID = round(r(p_score),0.001)
	
eststo col_2: ivregress 2sls lQ (lP = wave2)
	estadd local speed ""
	estadd local height "Y"
	
eststo col_3: ivregress 2sls lQ (lP = speed2)
	estadd local speed "Y"
	estadd local height ""
	
esttab col_*, se scalars("speed wind speed" "height wave height" "overID over-identification test (p-value)") label keep(lP)

esttab col_* using FishOverID.rtf, replace se scalars("speed wind speed" "height wave height" "overID over-identification test (p-value)") label keep(lP)
