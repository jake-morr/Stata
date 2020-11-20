clear
set more off
capture log close
log using Stataproject3.log, replace
use E:\econ5813\usa_000001.dat\econ5813_acs_d1.dta

************
* Pre-Work *
************

generate female = .
replace female =1 if sex==2
replace female =0 if sex==1

gen float schoolyr = 0
replace schoolyr = 2.5 if educd<=17
replace schoolyr = 5.5 if educd>=20 & educd<=23
replace schoolyr = 7.5 if educd>=24 & educd<=26
replace schoolyr = 9 if educd==30
replace schoolyr = 10 if educd==40
replace schoolyr = 11 if educd==50
replace schoolyr = 12 if educd>=60 & educd<=64
replace schoolyr = 13 if educd>=65 & educd<=71
replace schoolyr = 14 if educd>=80 & educd<=90
replace schoolyr = 16 if educd>=100 & educd<=101
replace schoolyr = 18 if educd>=110 & educd<=115
replace schoolyr = 20 if educd==116

generate weeksworked = .
replace weeksworked = 7 if wkswork2==1
replace weeksworked = 20 if wkswork2==2
replace weeksworked = 33 if wkswork2==3
replace weeksworked = 43.5 if wkswork2==4
replace weeksworked = 48.5 if wkswork2==5
replace weeksworked = 51 if wkswork2==6
drop if weeksworked <=26
generate wage = (( incwage/uhrswork)/weeksworked)

generate elem = 0
generate hs = 0
generate college = 0
generate ma = 0
generate phd = 0
replace elem = 1 if educd <= 61
replace hs = 1 if educd == 63 
replace hs = 1 if educd == 64
replace hs = 1 if educd == 65
replace hs = 1 if educd == 71
replace hs = 1 if educd == 81
replace college = 1 if educd == 101
replace college = 1 if educd == 115
replace ma =1 if educd == 114
replace phd = 1 if educd == 116

gen hispanic = (hispand~=0 & hispand~=900)
gen black = (raced==200 & hispanic==0)
gen asian = (raced>=400 & raced<=699) & hispanic==0
gen native = (raced>=300 & raced<=399) & hispanic==0
gen white = (raced==100 & hispanic==0)
gen othrace = (hispanic==0 & black==0 & asian==0 & native==0 & white==0)
gen check = hispanic+black+asian+native+white+othrace
sum check
drop check

**************
* Question 1 *
**************

generate race_cat5 = .
replace race_cat5 = 1 if white ==1
replace race_cat5 = 2 if black ==1
replace race_cat5 = 3 if asian ==1
replace race_cat5 = 4 if hispanic ==1
replace race_cat5 = 5 if native ==1
replace race_cat5 = 5 if othrace ==1

label variable race_cat5 "Race/Ethnicity Variable"
label define race_ethnicity 1 "white" 2 "black" 3 "asian" 4 "hispanic" 5 "native or other"
label values race_cat5 race_ethnicity

tabulate race_cat5, missing
tabulate race_cat5, nolab missing

**************
* Question 2 *
**************

tabstat wage age, by(race_cat5) stat(N mean sd min max)
tabstat wage age, by(race_cat5) stat(N mean sd min max) long col(stat)
tabstat wage age, by(race_cat5) stat(N mean sd min max) col(stat) format(%9.3g)

**************
* Question 3 *
**************

tabulate year, missing
assert year >=2010 & year <=2016
assert r(r) ==7

tabulate statefip, nolab missing
assert statefip >= 1 & statefip <= 56
assert r(r) ==51

**************
* Question 4 *
**************

tabulate statefip year, missing

preserve
gen samplesize = 1
tabulate statefip year, missing
collapse (count) samplesize (mean) age, by(statefip year)
tsset statefip year
assert r(balanced) == "strongly balanced"
restore

preserve
drop if statefip==8 & year==2012
tabulate statefip year, missing
gen samplesize = 1
collapse (count) samplesize (mean) age, by(statefip year)
tsset statefip year
assert r(balanced) == "unbalanced"
restore

**************
* Question 5 *
**************

keep if age >= 25 & age <= 30
generate year16 =.
replace year16 = (year+16) - age
label variable year16 "Year individual was 16"

* potential year range: 1991-2007
* min=(2010-25)+16=1996
*max=(2016-30)+16=2007

tab year16, missing

**************
* Question 6 *
**************

gen statefips = string(statefip,"%02.0f")
label variable statefips "State FIPS code (str)"
describe statefip statefips


**************
* Question 7 *
**************

#delimit ;
d,s;
merge m:1 statefips year16 using BLS-State-Annual-Unemployment_1976-2017.dta, keepusing (unemployment_rate) keep(match master);
d,s;
drop _merge;
#delimit cr;

**************
* Question 8 *
**************

generate unemp_cat3 = .
replace unemp_cat3 = 1 if unemployment_rate <4
replace unemp_cat3 = 2 if unemployment_rate >=4 & unemployment_rate <6
replace unemp_cat3 = 3 if unemployment_rate >=6

label variable unemp_cat3 "unemployment rate category"
label define unemp_cat3 1 "less than 4%" 2 "4% to 5.9%" 3 "6% or more"

assert inlist(unemp_cat3,1,2,3)

**************
* Question 9 *
**************

#delimit ;
d,s;
merge m:1 statefip year16 using County_Population1996-2010.dta, keep(match master);
d,s;
drop _merge;
#delimit cr;

generate population10 =.
replace population10= population/10000

assert float(population10)==float(432.6921) if year16==2000 & statefip==8

***************
* Question 10 *
***************

*check word document


***************
* Question 11 *
***************

histogram unemployment_rate, width(.5) start(2) percent xlabel(2(.5)8.5, ticks tlcolor(magenta))

***************
* Question 12 *
***************

preserve
collapse (mean) unemployment_rate schoolyr wage, by(year16)
#delimit ;
twoway line unemployment_rate year16,
 graphregion(color(white)) bgcolor(white) name(PanelA, replace);
twoway line wage year16, 
 graphregion(color(white)) bgcolor(white) name(PanelB, replace);
graph combine PanelA PanelB, col(1)
 graphregion(color(white)) name(Figure1, replace);
graph save Figure1 Econ5813PA3-Figure1.gph, replace;
#delimit cr;
restore

preserve
collapse (mean) unemployment_rate schoolyr wage, by(year16)
#delimit ;
twoway line unemployment_rate year16,
 graphregion(color(white)) bgcolor(white) name(PanelA, replace) title(Panel A: Unemployment on Wage);
twoway line wage year16, 
 graphregion(color(white)) bgcolor(white) name(PanelB, replace) title(Panel B: Year 16 on Wage);
graph combine PanelA PanelB, col(1)
 graphregion(color(white)) name(Figure1, replace);
graph save Figure1 Econ5813PA3-Figure1.gph, replace;
#delimit cr;
restore


***************
* Question 13 *
***************

ssc install estout

* (Model 1) Baseline wage regression.
eststo : regress wage i.unemp_cat3 $rhs, ///
 vce(cluster statefip)
estadd ysumm, mean
estadd local State_FE "No", replace
estadd local Year_FE "No", replace
test 2.unemp_cat3 3.unemp_cat3
* (Model 2) Add state fixed effects.
eststo : regress wage i.unemp_cat3 i.statefip $rhs, ///
 vce(cluster statefip) 
estadd ysumm, mean
estadd local State_FE "Yes", replace
estadd local Year_FE "No", replace
test 2.unemp_cat3 3.unemp_cat3
* (Model 3) Add state and birth-year fixed effects.
eststo : regress wage i.unemp_cat3 i.statefip i.year16 $rhs, ///
 vce(cluster statefip)
estadd ysumm, mean
estadd local State_FE "Yes", replace
estadd local Year_FE "Yes", replace
test 2.unemp_cat3 3.unemp_cat3
* (Model 4) Dependent variable = schoolyr
eststo : regress schoolyr i.unemp_cat3 i.statefip i.year16 $rhs, ///
 vce(cluster statefip)
estadd ysumm, mean
estadd local State_FE "Yes", replace
estadd local Year_FE "Yes", replace
test 2.unemp_cat3 3.unemp_cat3

**************************;
*** Output Regressions ***;
**************************;
#delimit ;
esttab using Econ5813pa3-Table1.csv,
replace label b(%9.3f) se(%9.3f) nogaps
title("Table 1: Wage regressions")
stats(State_FE Year_FE ymean r2 N,
label("State fixed effects"
"Year fixed effects"
"Mean of dependent variable"
"R-squared"
"Sample size") fmt(%9.3g));
#delimit cr;
eststo clear

***************
* Question 14 *
***************

* Check Word Document

***************
* Question 15 *
***************

* Check Word Document

***************
* Question 16 *
***************

* Check Word Document

***************
* Question 17 *
***************

* Check Word Document

***************
* Question 18 *
***************

* Check Word Document

***************
* Question 19 *
***************

generate birthyear =.
replace birthyear = year-age

* (Model 3*) Add state and birth-year fixed effects.
eststo : regress wage i.unemp_cat3 i.statefip i.birthyear $rhs, ///
 vce(cluster statefip)
estadd ysumm, mean
estadd local State_FE "Yes", replace
estadd local Year_FE "Yes", replace
test 2.unemp_cat3 3.unemp_cat3

***************
* Question 20 *
***************

*i
reg wage population

*ii
regress wage unemp_cat3
reg wage unemployment_rate







