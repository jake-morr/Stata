capture log close
log using psid-HeadStart_d3.log, replace
set linesize 255
set more off
set varabbrev off

clear all
use psid-HeadStart_d2.dta

************
* Pre-Work *
************


*labeling previously unlabeled variables

label variable headstart "Head Start indicator"
label variable preschool "Preschool indicator"
label variable nopreschool "No preschool indicator"
label variable crime "Crime Indicator"
label variable highschool_1995 ///
"Whether the individual had finished highschool in 1995"
label variable highschool_2015 ///
"Whether the individual had finished highschool in 2015"
label variable somecollege_1995 ///
"Whether the individual had attended any college in 1995"
label variable somecollege_2015 ///
"Whether the individual had attended any college in 2015"
label variable birthyear "Birthyear of the individual"
label variable white "White indicator variable"
label variable black "Black indicator variable"
label variable white_own "Reported own race as white"
label variable white_head "Reported the head of the household race as white"
label variable black_own "Reported own race as black"
label variable SiblingSample "Sibling in sample indicator"


*****************************************************************************
* Note: There is some commented out code that inlcudes my original attempts *
*****************************************************************************

**************
* Question 1 *
**************

gen firstborn =.
replace firstborn = 1 if i_birthorder==1
replace firstborn = 0 if inrange(i_birthorder,2,99)

label variable firstborn "First Born Child Indicator"



gen firstborn_not =.
replace firstborn_not = 1 if inrange(i_birthorder,2,14)
replace firstborn_not = 0 if i_birthorder == 1 | inrange(i_birthorder,98,99)

label variable firstborn_not "Not First Born Child Indicator"

gen firstborn_unk =.
replace firstborn_unk = 1 if inrange(i_birthorder,98,99)
replace firstborn_unk = 0 if inrange(i_birthorder,1,14)

label variable firstborn_unk "Unkown Order of Birth"


assert firstborn+firstborn_not+firstborn_unk==1
tab firstborn firstborn_not, missing cell



**************
* Question 2 *
**************

*use i_birthweight

gen LBW =.
*LBW = 991
replace LBW = 1 if i_birthweight == 991
replace LBW = 0 if inrange(i_birthweight,995,999)

label variable LBW "Low Birthweight"

gen LBW_not =.
**Not LBW = 995
replace LBW_not = 1 if i_birthweight == 995
replace LBW_not = 0 if LBW == 1 | inrange(i_birthweight,996,999)

*****We wouldn't typically use the LBW as conditional for LBW_not but in this
* case we can

label variable LBW_not "Not Low Birthweight"


gen LBW_unk =.
**Unkown  = 998, 999
replace LBW_unk = 1 if inrange(i_birthweight,996,999)
replace LBW_unk = 0 if LBW == 1 | LBW_not ==1
*Again, we wouldnt usually use the LBW and LBW_not to create the LBW_unk 
*varibale, but in this case we can

label variable LBW_unk "Unkown Birthweight"

assert LBW+LBW_not+LBW_unk==1
tab LBW LBW_not, missing cell

**********************************************************************
*use i_marstat_mother

gen mom_single =.
replace mom_single = 1 if inrange(i_marstat_mother,2,7)
replace mom_single = 0 if i_marstat_mother == 1 | inrange(i_marstat_mother,8,9)

label variable mom_single "Single Mother"

gen mom_married =.
replace mom_married = 1 if i_marstat_mother == 1
replace mom_married = 0 if inrange(i_marstat_mother,2,9)

label variable mom_married "Mother Married"

gen mom_single_unk =.
replace mom_single_unk = 1 if inrange(i_marstat_mother,8,9)
replace mom_single_unk = 0 if inrange(i_marstat_mother,1,7)

label variable mom_single_unk "Unkown marital status"

assert mom_single+mom_married+mom_single_unk==1
tab mom_single mom_married, missing cell

**************
* Question 3 *
**************

gen mom_highschool =.


label variable mom_highschool "If mom ever finished highschool"


*replace mom_i_yearseduc_1995 = r(mean) if mom_i_yearseduc_1995 ==. | ///
*mom_i_yearseduc_1995 == 0 | inrange(mom_i_yearseduc_1995,98,99)

 foreach yy of numlist 2015(2)1999 1997/1995 {
 replace mom_highschool = 1 if inrange(mom_i_yearseduc_`yy',12,17) ///
 & mom_highschool==.
 replace mom_highschool = 0 if inrange(mom_i_yearseduc_`yy',1,11) ///
 & mom_highschool ==.
}

*replace mom_highschool = 1 if mom_highschool ==. & mom_edyrs_imputed > 12

*sum mom_i_yearseduc_1995


tabulate mom_highschool, missing

gen mom_edyrs =.
foreach yy of numlist 2015(2)1999 1997/1995 {
 replace mom_edyrs = mom_i_yearseduc_`yy' if inrange(mom_i_yearseduc_`yy',1,17) ///
 & mom_edyrs==.
 *replace mom_highschool = 0 if inrange(mom_i_yearseduc_`yy',0,11) ///
 *| inrange(mom_i_yearseduc_`yy',98,99)
 }

*label variable mom_edyrs "Mothers completed years of education"
 
generate mom_edyrs_imputed =0
replace mom_edyrs_imputed = 1 if mom_i_yearseduc_1995 ==. | ///
mom_i_yearseduc_1995 == 0 | inrange(mom_i_yearseduc_1995,98,99)

*label variable mom_edyrs_imputed "Imputed indicator"

sum mom_i_yearseduc_1995

replace mom_edyrs = r(mean) if mom_i_yearseduc_1995 ==. | ///
mom_i_yearseduc_1995 == 0 | inrange(mom_i_yearseduc_1995,98,99)
 
*replace mom_edyrs = mom_edyrs_imputed if mom_edyrs ==.

 tabulate mom_edyrs, missing
 
gen mom_hs_or_less =.

replace mom_hs_or_less = 1 if inrange(mom_i_yearseduc_1995,1,12)
replace mom_hs_or_less = 0 if inrange(mom_i_yearseduc_1995,13,19)

label variable mom_hs_or_less "Mothers education less than 12 years"

*replace mom_hs_or_less = 0 if mom_hs_or_less ==. & mom_edyrs_imputed > 12

tabulate mom_hs_or_less, missing

gen dad_highschool =.

*label variable dad_highschool "If Dad ever finished highschool"

generate dad_edyrs_imputed =0
replace dad_edyrs_imputed = 1 if dad_i_yearseduc_1995 ==. | ///
dad_i_yearseduc_1995 == 0 | inrange(dad_i_yearseduc_1995,98,99)

*label variable dad_edyrs_imputed "Imputed indicator"


foreach yy of numlist 2015(2)1999 1997/1995 {
 replace dad_highschool = 1 if inrange(dad_i_yearseduc_`yy',12,17) ///
 & dad_highschool==.
 replace dad_highschool = 0 if inrange(dad_i_yearseduc_`yy',1,11) ///
 & dad_highschool ==.
 }

* replace dad_highschool = 0 if dad_highschool ==. & dad_edyrs_imputed < 12

 
 tabulate dad_highschool, missing
 
gen dad_edyrs =.

*label variable dad_edyrs "Father years of education completed"

foreach yy of numlist 2015(2)1999 1997/1995 {
 replace dad_edyrs = dad_i_yearseduc_`yy' if inrange(dad_i_yearseduc_`yy',1,17) ///
 & dad_edyrs==.
 *replace mom_highschool = 0 if inrange(mom_i_yearseduc_`yy',0,11) ///
 *| inrange(mom_i_yearseduc_`yy',98,99)
 }

*replace dad_edyrs = dad_edyrs_imputed if dad_edyrs ==.

sum dad_i_yearseduc_1995

replace dad_edyrs = r(mean) if dad_i_yearseduc_1995 ==. | ///
dad_i_yearseduc_1995 == 0 | inrange(dad_i_yearseduc_1995,98,99)


 
 tabulate dad_edyrs, missing
 
gen dad_hs_or_less =.

replace dad_hs_or_less = 1 if inrange(dad_i_yearseduc_1995,1,12)
replace dad_hs_or_less = 0 if inrange(dad_i_yearseduc_1995,13,19)

*replace dad_hs_or_less = 1 if dad_hs_or_less ==. & dad_edyrs_imputed < 12

*label variable dad_hs_or_less "Father education less than 12 years"

tab dad_hs_or_less, missing 



*labeling variables, cut and paste from assignment*

label variable mom_highschool "Mother completed high school (1995)" 
label variable mom_edyrs "Mother years of education (1995)" 
label variable mom_hs_or_less "Mother completed high school or less" 
 
label variable dad_highschool "Father Completed high school (1995)" 
label variable dad_edyrs "Father years of education (1995)" 
label variable dad_hs_or_less "Father completed high school or less" 

***tabulations cut and paste from assingment

tab mom_highschool mom_hs_or_less, missing

tabstat mom_edyrs, by(mom_edyrs_imputed) stats(n mean semean min max) missing
tab dad_highschool dad_hs_or_less, missing
tabstat dad_edyrs, by(dad_edyrs_imputed) stats(n mean semean min max) missing

**************
* Question 4 *
**************
generate yearage3 =.
gen yearage4 =.
gen yearage5 =.
gen yearage6 =.
gen yearage23 =.
gen yearage24 =.
gen yearage25 =.
gen yearage26 =.
gen yearage27 =.
gen yearage28 =.



*global yearage "yearage3 yearage4 yearage5 yearage6 yearage23 yearage24 yearage25"

foreach age of numlist 3/6 23/28 {
label variable yearage`age' "Year individual turned `age'"
}

foreach age of numlist 3/6 23/28 {
replace yearage`age' = birthyear + `age'
}

foreach age of numlist 3/6 23/28 {
replace yearage`age' =. if yearage`age' >1996 & mod(yearage`age',2)
}

sum yearage*, sep(4)

**************
* Question 5 *
**************

gen f_familysize4 =.

foreach yy of numlist 1970/1983 {
replace f_familysize4 = f_familysize_`yy' if yearage4 == `yy'
}
label variable f_familysize4 "family size at 4 years old"

gen f_familysize4_imputed =.

label variable f_familysize4_imputed "Imputed family size at age 4"

replace f_familysize4_imputed = f_familysize4

sum f_familysize_1995

replace f_familysize4_imputed = r(mean) if f_familysize4 ==.

tabulate f_familysize4_imputed


tabstat f_familysize4, by(f_familysize4_imputed) ///
stats(n mean semean min max) missing

**************
* Question 6 *
**************
gen year =.

label variable year "Year age for merge"

/*In order to get the price deflator in 1999 dollars I modified the data set 
given to us before merging.
In the future it would be better to make that adjustment in this program so I could
easily change to a different base year.
*/ 

foreach age of numlist 3/6 23/28 {
replace year = birthyear + `age'
merge m:1 year using ImplicitPriceDeflator-PCE-1929-2017.dta, keepusing(ipd_pce) keep(match master)
drop _merge
gen ipd_pce`age' = ipd_pce
drop ipd_pce
}
foreach age of numlist 3/6 23/28 {
label variable ipd_pce`age' "ipd_pce when `age' "
}

sum ipd_pce*, sep(4)

/*
foreach age of numlist 3/6 23/25 {
merge m:1 year using ImplicitPriceDeflator-PCE-1929-2017.dta, keepusing(year ipd_pce) keep(match master)
drop _merge
}
generate ipd_pce3 =.
gen ipd_pce4 =.
gen ipd_pce5 =.
gen ipd_pce6 =.
gen ipd_pce23 =.
gen ipd_pce24 =.
gen ipd_pce25 =.


foreach age of numlist 3/6 23/25 {
replace ipd_pce`age' = ipd_pce
}

*/

**************
* Question 7 *
**************


/* I think there might be an error with this code that i am yet to identify. I 
I believe using an egen code will help solve this problem 
*/ 

foreach age of numlist 3/6 {
generate f_income_age_`age' =.
foreach yy of numlist 1969/1985 {
replace f_income_age_`age' = f_faminc_`yy' if yearage`age' == `yy'
}
}

foreach age of numlist 3/6 {
label variable f_income_age_`age' "Family income at `age' "
}

sum f_income_age_3 if f_income_age_3 ~=.
generate f_income_age_3_imputed = r(mean) if f_income_age_3 ==.

sum f_income_age_4 if f_income_age_4 ~=.
generate f_income_age_4_imputed = r(mean) if f_income_age_4 ==.

sum f_income_age_5 if f_income_age_5 ~=.
generate f_income_age_5_imputed = r(mean) if f_income_age_5 ==.

sum f_income_age_6 if f_income_age_6 ~=.
generate f_income_age_6_imputed = r(mean) if f_income_age_6 ==.

generate f_earnings3_6 = ( f_income_age_3 + f_income_age_4 + f_income_age_5 + ///
f_income_age_6 ) / 4

generate f_earnings3_6_imputed = ( f_income_age_3_imputed + ///
f_income_age_4_imputed + f_income_age_4_imputed + f_income_age_5_imputed + ///
f_income_age_6_imputed ) / 4

foreach age of numlist 3/6 {
label variable f_income_age_`age'_imputed "Imputed household income at `age' "
}

label variable f_earnings3_6_imputed "Imputed family income age 3-6 "

label variable f_earnings3_6 "family earnings age 3-6"

replace f_earnings3_6 = (f_earnings3_6)/1000

replace f_earnings3_6_imputed = (f_earnings3_6_imputed)/1000

generate f_ln_earnings3_6 = ln(f_earnings3_6)

label variable f_ln_earnings3_6 "Natural Log of average household income age 3-6 "

tabstat f_earnings3_6 f_ln_earnings3_6, by(f_earnings3_6_imputed) ///
stats(n mean semean min max) missing col(stats) longstub

*foreach yy of numlist 1969/1985 {
*generate family_earning_1969 = f_faminc_1969 if yearage3 == f_faminc_1969
*}
*generate f_earnings3_6 =.

**************
* Question 8 *
**************

foreach age of numlist 23/28 {
generate earnings`age' =.
foreach yy of numlist 1989(2)2004 {
replace earnings`age' = h_income_`yy' +1 if yearage`age' == `yy' ///
 & currentHead_`yy' == 1
}
}

foreach age of numlist 23/28 {
label variable earnings`age' "earnings at `age' "
}

foreach age of numlist 23/28 {
foreach yy of numlist 1989(2)2004 {
replace earnings`age' = h_income_`yy' +1 if yearage`age' == `yy' ///
 & currentWife_`yy' == 1
}
}

egen earnings2328 = rmean(earnings23 earnings24 earnings25 earnings26 ///
 earnings27 earnings28)

label variable earnings2328 "Average earnings age 23-28 "

/*generate earnings2325 = .
replace earnings2325 = ( earnings23 + earnings25 ) / 2

replace earnings2325 = earnings24 if earnings2325 ==.
*/

replace earnings2328 = (earnings2328) / 1000

generate ln_earnings2328 = ln(earnings2328)

label variable ln_earnings2328 "Natural Log of average earnings age 23-28 "

sum earnings2328 ln_earnings2328

 quietly compress
   d,s
   save psid-HeadStart_d3.dta, replace

log close
set more on
