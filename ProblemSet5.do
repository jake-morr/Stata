***********************
*** Problem Set # 5 ***
***********************

clear

capture log close
log using ProblemSet5.log, replace

insheet using "nsduh_tables_replication.csv", comma

set more off

***************************************************
*** Create the runing varaible, square and cube ***
*** of the running variable, cutoff varaible,   ***
*** and interaction terms                       ***
***************************************************

gen rv = age - 21
gen rv2 = rv^2
gen rv3 = rv^3
gen D = rv>=0
replace D = 0 if rv<0
gen D_rv = D*rv 
gen D_rv2 = D*rv2
gen D_rv3 = D*rv3



 

*************************************************
*** Creat triangular kernal weights (kweight) ***
*************************************************

gen    bandwidth   = 3 
gen kweight = 1 - (abs(rv)/bandwidth)
replace kweight = 0 if abs(rv)>bandwidth


#delimit ;

**********;
* Part a *;
**********;

twoway  scatter alc age if age>=18 & age<=24 ||,
        graphregion(color(white)) bgcolor(white) legend(off)
        ytitle("Alcohol use (%)", size(medsmall))
        xtitle("Age", size(medsmall)) xlabel(18(1)24) xtitle("Age")
        title("Figure 1A: Alchol use by age", size(medium) position(11))
        name(Figure2A, replace) xline(21);
		
twoway  scatter mj age if age>=18 & age<=24 ||,
        graphregion(color(white)) bgcolor(white) legend(off)
        ytitle("Marijuana use (%)", size(medsmall))
        xtitle("Age", size(medsmall)) xlabel(18(1)24) xtitle("Age")
        title("Figure 1A: Marijuana use by age", size(medium) position(11))
        name(Figure2B, replace) xline(21);		

**********;
* Part b *;
**********;
#delimit cr



regress alc D rv [aweight = kweight], robust

predict yhatalc, xb

regress mj D rv [aweight = kweight], robust

predict yhatmj, xb

regress alc D age [aweight = kweight], robust
regress mj D age [aweight = kweight], robust

**********
* Part c *
**********


#delimit ; 
twoway  scatter alc age if age>=18 & age<=24 ||
		line	yhatalc age if age<21  & age>=18  ||
        line    yhatalc age if age>=21 & age<=24  ||
		if kweight != 0,
        graphregion(color(white)) bgcolor(white) legend(off)
        ytitle("Alcohol use (%)", size(medsmall))
        xtitle("Age", size(medsmall)) xlabel(18(1)24) xtitle("Age")
        title("Figure 2C: Alchol use by age", size(medium) position(11))
        name(Figure2C, replace) xline(21);
		
twoway  scatter mj age if age>=18 & age<=24 ||
		line	yhatmj age if age<21  & age>=18  ||
        line    yhatmj age if age>=21 & age<=24  ||
		if kweight != 0,
        graphregion(color(white)) bgcolor(white) legend(off)
        ytitle("Marijuana use (%)", size(medsmall))
        xtitle("Age", size(medsmall)) xlabel(18(1)24) xtitle("Age")
        title("Figure 2C: Marijuana use by age", size(medium) position(11))
        name(Figure2C2, replace) xline(21);

		
#delimit cr
**********;
* Part d *;
**********;

regress alc D D_rv2 D_rv3 rv rv2 rv3 [aweight = kweight], robust

predict yhatalc2

regress mj D D_rv2 D_rv3 rv rv2 rv3 [aweight = kweight], robust

predict yhatmj2

**********;
* Part e *;
**********;

#delimit ; 
twoway  scatter alc age if age>=18 & age<=24 ||
		line	yhatalc2 age if age<21  & age>=18  ||
        line    yhatalc2 age if age>=21 & age<=24  ||
		if kweight != 0,
        graphregion(color(white)) bgcolor(white) legend(off)
        ytitle("Alcohol use (%)", size(medsmall))
        xtitle("Age", size(medsmall)) xlabel(18(1)24) xtitle("Age")
        title("Figure 2E: Alchol use by age", size(medium) position(11))
        name(Figure2E, replace) xline(21);
		
twoway  scatter mj age if age>=18 & age<=24 ||
		line	yhatmj2 age if age<21  & age>=18  ||
        line    yhatmj2 age if age>=21 & age<=24  ||
		if kweight != 0,
        graphregion(color(white)) bgcolor(white) legend(off)
        ytitle("Marijuana use (%)", size(medsmall))
        xtitle("Age", size(medsmall)) xlabel(18(1)24) xtitle("Age")
        title("Figure 2E: Marijuana use by age", size(medium) position(11))
        name(Figure2E2, replace) xline(21);

		
#delimit cr


**********
* Part g *
**********


************************
*** Bandwidth of 2.5 ***
************************
gen    bandwidth2   = 2.5 
gen kweight2 = 1 - (abs(rv)/bandwidth2)
replace kweight = 0 if abs(rv)>bandwidth2

regress alc D D_rv2 D_rv3 rv rv2 rv3 [aweight = kweight2], robust

regress mj D D_rv2 D_rv3 rv rv2 rv3 [aweight = kweight], robust

************************
*** Bandwidth of 1.5 ***
************************

gen    bandwidth3   = 1.5 
gen kweight3 = 1 - (abs(rv)/bandwidth3)
replace kweight = 0 if abs(rv)>bandwidth3

regress alc D D_rv2 D_rv3 rv rv2 rv3 [aweight = kweight3], robust

regress mj D D_rv2 D_rv3 rv rv2 rv3 [aweight = kweight], robust


**********
* Part h *
**********


**********************
*** Uniform kernel ***
**********************

gen    bandwidth4   = 3 
gen kweight4 = 1 if abs(rv)<=bandwidth4
replace kweight = 0 if abs(rv)>bandwidth4

regress alc D D_rv2 D_rv3 rv rv2 rv3 [aweight = kweight4], robust

regress mj D D_rv2 D_rv3 rv rv2 rv3 [aweight = kweight], robust



**************************
*** Close the log file ***
**************************

log close

