capture log close
log using econ6054-problem_set.log, replace
set linesize 255
set more off
set varabbrev off

clear all
use ps1.dta

**************
* Question 1 *
**************
preserve
*use data from only 1991 to 1996

keep if year >= 1991 & year <=1996
tab year

*A refer to Word Document

*B
*'After' expansion variable
gen post93 =.
replace post93 = 0 if year >= 1991 & year <=1993
replace post93 = 1 if year > 1993 & year <=1996

*'treatment' variable
gen anykids =0
replace anykids = 1 if children >0
tabulate anykids

*'filing unit' size
gen file_unit = children + 1
tabulate file_unit

*earning conditional on working
gen earn_work = earn if work==1
sum earn_work

*summary statistics
sum (age ed nonwhite file_unit earn earn_work work) if anykids==0
sum (age ed nonwhite file_unit earn earn_work work) if anykids==1
sum (age ed nonwhite file_unit earn earn_work work) if children==1
sum (age ed nonwhite file_unit earn earn_work work) if children >1




*C


*D
*generating interaction term
generate post_treatment = ( post93 * anykids)

*difference-in-difference estimator with no covariates
reg work post93 anykids post_treatment

*E
*age squared and education squared
gen age_sqd = age^2
gen ed_sqd = ed^2

*Demographic Characteristics
reg work post93 anykids post_treatment unearn nonwhite age age_sqd ed ed_sqd

*F
*generating 'twokids' dummy variable as new treatment variable
gen twokids =.
replace twokids = 0 if children == 1
replace twokids = 1 if children >= 2

*generating new interaction term
gen post_treatment2 = post93 * twokids

*regressing for two children
*reg work post93 twokids post_treatment2 if twokids== 1
reg work post93 twokids post_treatment2


**************
* Question 2 *
**************
restore
*limiting sample to only women that have children
drop if children == 0

*creating the stateeitc variable
generate stateeitc = 0
replace stateeitc = 1 if statefip == 6
replace stateeitc = 1 if statefip == 8
replace stateeitc = 1 if statefip == 9
replace stateeitc = 1 if statefip == 10
replace stateeitc = 1 if statefip == 11
replace stateeitc = 1 if statefip == 17
replace stateeitc = 1 if statefip == 18
replace stateeitc = 1 if statefip == 19
replace stateeitc = 1 if statefip == 20
replace stateeitc = 1 if statefip == 22
replace stateeitc = 1 if statefip == 23
replace stateeitc = 1 if statefip == 24
replace stateeitc = 1 if statefip == 25
replace stateeitc = 1 if statefip == 26
replace stateeitc = 1 if statefip == 31
replace stateeitc = 1 if statefip == 34
replace stateeitc = 1 if statefip == 35
replace stateeitc = 1 if statefip == 36
replace stateeitc = 1 if statefip == 37
replace stateeitc = 1 if statefip == 39
replace stateeitc = 1 if statefip == 40
replace stateeitc = 1 if statefip == 41
replace stateeitc = 1 if statefip == 44
replace stateeitc = 1 if statefip == 50
replace stateeitc = 1 if statefip == 51
replace stateeitc = 1 if statefip == 55

*B
reg work stateeitc

*C
*State by Year fixed effects
reg work stateeitc i.statefip i.year






log close
set more on
