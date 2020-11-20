clear
set more off
capture log close
log using Stataproject4.log, replace
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

keep if age >= 25 & age <= 30
generate year16 =.
replace year16 = (year+16) - age
label variable year16 "Year individual was 16"

gen statefips = string(statefip,"%02.0f")
label variable statefips "State FIPS code (str)"
describe statefip statefips


generate population10 =.
replace population10= population/10000

generate birthyear =.
replace birthyear = year-age

**************
* Question 3 *
**************
generate QOB1 = 0
generate QOB2 = 0
generate QOB3 = 0
generate QOB4 = 0

replace QOB1 = 1 if birthqtr ==1
replace QOB2 = 1 if birthqtr ==2
replace QOB3 = 1 if birthqtr ==3
replace QOB4 = 1 if birthqtr ==4

gen check = QOB1 + QOB2 + QOB3 + QOB4
assert check ==1
drop check

*************************************************
*** Question #3 - Schooling/Year interactions ***
*************************************************
sum year
foreach yy of numlist `r(min)'/`r(max)' {
 gen year`yy' = (year==`yy')
 gen schoolyr`yy' = schoolyr*year`yy'
 label variable year`yy' "Year `yy'"
 label variable schoolyr`yy' "Year `yy' X schoolyr"
}






**************
* Question 5 *
**************
preserve
collapse (mean) schoolyr wage, by(year)
sum year
local firstyear = r(min)
local lastyear = r(max)
#delimit ;
twoway connected schoolyr year,
 title("Panel A: Average years of schooling, by year",
 size(medium) position(11) nobox lcolor(none))
 xtitle("") xlabel(`firstyear'(1)`lastyear', labsize(small))
 ytitle("Years of schooling") nodraw
 graphregion(color(white)) bgcolor(white) name(PanelA, replace);
twoway connected wage year,
 title("Panel B: Average wage, by year",
 size(medium) position(11) nobox lcolor(none))
 xtitle("Year") xlabel(`firstyear'(1)`lastyear', labsize(small))
 ytitle("Avearge Wage") nodraw
 graphregion(color(white)) bgcolor(white) name(PanelB, replace);
graph combine PanelA PanelB, col(1) xsize(7) ysize(5)
 graphregion(color(white)) name(Figure1, replace);
graph save Figure1 Econ5813PA4-Figure1.gph, replace;
#delimit cr;
restore

*************
* Question 6*
*************
generate ln_wage = ln(wage)

reg ln_wage schoolyr i.race_cat5 female i.age, vce(cluster statefip)
reg ln_wage schoolyr i.race_cat5 female i.age i.statefip, vce(cluster statefip)
reg ln_wage schoolyr i.race_cat5 female i.age i.statefip i.year, vce(cluster statefip)


xtreg ln_wage schoolyr i.race_cat5 female i.age i.year, fe i(statefip) cluster(statefip)

**************
* Question 7 *
**************

*first stage no controls
reg schoolyr QOB1 QOB2 QOB3
test QOB1 QOB2 QOB3
predict schoolyr_hat, xb
*second stage
reg ln_wage schoolyr_hat, vce(cluster statefip)
ivregress 2sls ln_wage (schoolyr = QOB1 QOB2 QOB3)

reg ln_wage schoolyr i.race_cat5 female i.age, vce(cluster statefip)
*first stage regression
reg schoolyr i.race_cat5 female i.age QOB1 QOB2 QOB3, vce(cluster statefip)
test QOB1 QOB2 QOB3
predict schoolyr_hat_2, xb
*second stage
reg ln_wage schoolyr_hat_2 i.race_cat5 female i.age, vce(cluster statefip)
ivregress 2sls ln_wage i.race_cat5 female i.age (schoolyr = QOB1 QOB2 QOB3)

**************
* Question 8 *
**************
ssc install estout
************************************************
*** Table #4 - Returns to schooling, by year ***
************************************************
global rhs "i.age i.race_cat5 female"
sum year
foreach yy of numlist `r(min)'/`r(max)' {
di _newline(3) "Year: " `yy'
eststo: regress ln_wage schoolyr $rhs i.statefip ///
if year==`yy', robust
estadd ysumm, mean
estadd local Age_FE "Yes", replace
estadd local State_FE "Yes", replace
global ctitle = `"$ctitle"' + `""`yy'" "'
}
*******************************************;
*** Output Table #4 - Alternate version ***;
*******************************************;
#delimit ;
 esttab using econ5813PA4-Table4ALT.csv,
 replace label b(%9.4f) se(%9.4f) nogaps
 star(* .1 ** .05 *** .01)
 drop(25.age 1.race_cat5 *.age *.statefip)
 title("Table 4: Returns to schooling by year")
 mtitle($ctitle)
 stats(Age_FE State_FE ymean r2 N,
 label("Age fixed effects"
 "State fixed effects"
"Mean of dependent variable"
"R-squared"
 "Sample size") fmt(%9.4g));
#delimit cr;
eststo clear
macro drop ctitle

**************
* Question 9 *
**************


reg ln_wage schoolyr i.year schoolyr2010 schoolyr2011 schoolyr2012 schoolyr2013 schoolyr2014 schoolyr2015
test schoolyr2010 schoolyr2011 schoolyr2012 schoolyr2013 schoolyr2014 schoolyr2015

reg ln_wage i.year schoolyr2010 schoolyr2011 schoolyr2012 schoolyr2013 schoolyr2014 schoolyr2015 schoolyr2016

***************
* Question 15 *
***************
*robustness check 1
reg ln_wage schoolyr i.race_cat5 female i.age elem hs ma phd
reg ln_wage schoolyr i.race_cat5 female i.age

*robustness check 2
reg ln_wage schoolyr i.race_cat5 female i.age schltype
reg ln_wage schoolyr i.race_cat5 female i.age

*robustness check 3
reg ln_wage schoolyr i.race_cat5 female i.age marst
reg ln_wage schoolyr i.race_cat5 female i.age 


set more on
log close
