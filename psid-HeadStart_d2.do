****************************
*** psid-HeadStart_d2.do ***
****************************

capture log close
log using psid-HeadStart_d2.log, replace
set linesize 255
set more off
set varabbrev off

clear all
use psid-HeadStart_d1.dta

************************************************************************
*** Replication of Garces, Thomas, Currie (2002) Summary Statistics  ***
************************************************************************

******************************
*** Head Start / Preschool ***
******************************

gen headstart =.
gen preschool =.
gen nopreschool =.

replace headstart = 1 if i_headstart_1995==1
replace headstart = 0 if i_headstart_1995==5

replace preschool = 1 if i_preschool_1995==1
replace preschool = 0 if i_preschool_1995==5
replace preschool = 0 if i_headstart_1995==1

replace nopreschool = 1 if i_preschool_1995==5
replace nopreschool = 0 if i_headstart_1995==1
replace nopreschool = 0 if i_preschool_1995==1

assert headstart+preschool+nopreschool==1 if headstart+preschool+nopreschool~=.
*************
*** Crime ***
*************

gen crime = i_crime_1995==1 if inlist(i_crime_1995,1,5)

*gen crime =.
*replace crime = 1 if i_crime_1995==1
*replace crime = 0 if i_crime_1995==0


*****************
*** Education ***
*****************
gen highschool_1995  = i_yearseduc_1995>=12 if inrange(i_yearseduc_1995,1,17) 
gen somecollege_1995 = i_yearseduc_1995>=13 if inrange(i_yearseduc_1995,1,17)
*gen highschool_1995 =0
*gen somecollege_1995 =0

*replace highschool_1995=1 if i_yearseduc_1995 >=12
*drop if i_yearseduc_1995 == 99
*drop if i_yearseduc_1995 == 0
*replace somecollege_1995 = 1 if i_yearseduc_1995 >12

gen highschool_2015 =.
gen somecollege_2015=.





foreach yy of numlist 2015(2)1999 1997/1995 {
 replace highschool_2015  = i_yearseduc_`yy'>=12 if inrange(i_yearseduc_`yy',1,17) & highschool_2015==.
 replace somecollege_2015 = i_yearseduc_`yy'>=13 if inrange(i_yearseduc_`yy',1,17) & somecollege_2015==.
 }
*replace highschool_2015 = i_yearseduc_`yy' >=12 if inrange(i_yearseduc_`yy',1,17) & highschool_2015==.
*replace somecollege_2015 = i_yearseduc_`yy' >=13 if inrange(i_yearseduc_`yy',1,17) & somecollege_2015==.
*}


****************************************
*** Birth year                       ***
*** -------------------------------- ***
*** Reported birth year does chage.  ***
*** Use reported birth year in 1995  ***
*** or first reported birth year if  ***
*** missing in 1995.                 ***
****************************************

gen birthyear =.

foreach yy of numlist 1995 1983/1997 1999(2)2015 {
replace birthyear = i_birthyear_`yy' if birthyear==.
replace birthyear =. if birthyear ==0 | birthyear==9999
}


*******************************
*** Imputed Race            ***
*** ----------------------- ***
*** In all years:           ***
***   1 = white             ***
***   2 = black             ***
***   1 - 8 are valid codes ***
*******************************

gen white =.
gen black =.

gen white_own =.
replace white_own = 0 if inrange(ownrace1,1,8) | inrange(ownrace2,1,8) | inrange(ownrace3,1,8)
replace white_own = 1 if ownrace1 == 1 | ownrace2 == 1 | ownrace3 == 1

gen white_head=.
replace white_head = 0 if inrange(headrace1,1,8) | inrange(headrace2,1,8) | inrange(headrace3,1,8)
replace white_head = 1 if headrace1 == 1 | headrace2 == 1 | headrace3 == 1


gen black_own=.
replace black_own = 0 if inrange(ownrace1,1,8) | inrange(ownrace2,1,8) | inrange(ownrace3,1,8)
replace black_own = 1 if ownrace1 == 2 | ownrace2 == 2 | ownrace3 == 2


gen black_head=.
replace black_head = 0 if inrange(headrace1,1,8) | inrange(headrace2,1,8) | inrange(headrace3,1,8)
replace black_head = 1 if headrace1 == 2 | headrace2 == 2 | headrace3 == 2


gen white_mom_own =.
replace white_mom_own = 0 if inrange(mom_ownrace1,1,8) | inrange(mom_ownrace2,1,8) | inrange(mom_ownrace3,1,8)
replace white_mom_own = 1 if mom_ownrace1 == 1 | mom_ownrace2 == 1 | mom_ownrace3 == 1

gen white_mom_head=.
replace white_mom_head = 0 if inrange(mom_headrace1,1,8) | inrange(mom_headrace2,1,8) | inrange(mom_headrace3,1,8)
replace white_mom_head = 1 if mom_headrace1 == 1 | mom_headrace2 == 1 | mom_headrace3 == 1

gen black_mom_own =.
replace black_mom_own = 0 if inrange(mom_ownrace1,1,8) | inrange(mom_ownrace2,1,8) | inrange(mom_ownrace3,1,8)
replace black_mom_own = 1 if mom_ownrace1 == 2 | mom_ownrace2 == 2 | mom_ownrace3 == 2


gen black_mom_head=.
replace black_mom_head = 0 if inrange(mom_headrace1,1,8) | inrange(mom_headrace2,1,8) | inrange(mom_headrace3,1,8)
replace black_mom_head = 1 if mom_headrace1 == 2 | mom_headrace2 == 2 | mom_headrace3 == 2


gen white_dad_own =.
replace white_dad_own = 0 if inrange(dad_ownrace1,1,8) | inrange(dad_ownrace2,1,8) | inrange(dad_ownrace3,1,8)
replace white_dad_own = 1 if dad_ownrace1 == 1 | dad_ownrace2 == 1 | dad_ownrace3 == 1

gen white_dad_head=.
replace white_dad_head = 0 if inrange(dad_headrace1,1,8) | inrange(dad_headrace2,1,8) | inrange(dad_headrace3,1,8)
replace white_dad_head = 1 if dad_headrace1 == 1 | dad_headrace2 == 1 | dad_headrace3 == 1

gen black_dad_own =.
replace black_dad_own = 0 if inrange(dad_ownrace1,1,8) | inrange(dad_ownrace2,1,8) | inrange(dad_ownrace3,1,8)
replace black_dad_own = 1 if dad_ownrace1 == 2 | dad_ownrace2 == 2 | dad_ownrace3 == 2

gen black_dad_head=.
replace black_dad_head = 0 if inrange(dad_headrace1,1,8) | inrange(dad_headrace2,1,8) | inrange(dad_headrace3,1,8)
replace black_dad_head = 1 if dad_headrace1 == 2 | dad_headrace2 == 2 | dad_headrace3 == 2


gen white_race =.
gen black_race=.

replace white_race=white_mom_own
replace black_race=black_mom_own

replace white_race=white_mom_head if white_race ==.
replace black_race=black_mom_head if black_race ==.

replace white_race=white_own if white_race ==.
replace black_race=black_own if black_race ==.

replace white_race=white_head if white_race ==.
replace black_race=black_head if black_race ==.

replace white_race=white_dad_own if white_race ==.
replace black_race=black_dad_own if black_race ==.

replace white_race=white_dad_head if white_race ==.
replace black_race=black_dad_head if black_race ==.

replace black=black_race
replace white=white_race
replace white=0 if black ==1

tab black_race white_race, missing 
tab black white, missing 
assert inlist(white+black,0,1,.) 
assert white==. if black==. 
assert black==. if white==. 

********************************************************************
*** Sample restrictions                                          ***
*** ------------------------------------------------------------ ***
*** The sample includes individuals:                             ***
***                                                              ***
*** 1.  Who have valid responses to the 1995 Head Start,         ***
***     preschool, crime and education questions.                ***
*** 2.  Who have birth years 1966 through 1997.                  ***
*** 3.  Are black or white.                                      ***
*** 4.  Are not from the PSID immigrant or Latino samples.       ***
********************************************************************

keep if inlist(i_headstart_1995,1,5) 
keep if inlist(i_preschool_1995,1,5)
keep if inlist(i_crime_1995,1,5)  
*keep if inrange(nopreschool,0,1)
keep if inrange(i_yearseduc_1995,1,17)
keep if inrange(birthyear,1966,1997)
keep if white==1 | black==1
drop if inlist(PSIDSample,2,3,5,6)


**********************
*** Sibling Sample ***
**********************
bysort mother_ID : gen SiblingSample = (_N>1 & mother_ID~=.) 

*egen num_sibs = count(mother_ID), by(mother_ID)
*gen SiblingSample = num_sibs>1

*gen SiblingSample =0

*egen tag = tag(mother_ID)

*replace SiblingSample = 1 if tag == 0



*****************
*** Save Data ***
*****************

   d,s
   compress
   d,s
   save psid-HeadStart_d2.dta, replace

log close
set more on
