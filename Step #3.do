clear
set more off
capture log close
log using replictionstep#3.log, replace
use E:\Econ5823\Extract2-14-2019\psid-HeadStart_d1



#delimit ;
   global parentVars "female i_age_1995 i_yearseduc_*
                      ownrace1 ownrace2 ownrace3 ownrace_year
                      headrace1 headrace2 headrace3 headrace_year
                      ownspanish ownspanish_year
                      headspanish headspanish_year";
#delimit cr;

preserve

keep $parentVars person_ID

clonevar mother_ID = person_ID
clonevar father_ID = person_ID

foreach var of varlist $parentVars {
clonevar mom_`var' = `var'
clonevar dad_`var' = `var'
local lbl : variable label `var'
label variable mom_`var' `"(Mom) `lbl'"'
label variable dad_`var' `"(Dad) `lbl'"' 
}

drop $parentVars person_ID

*save psid-HeadStart_d1_parent.dta, replace


restore 

merge m:1 mother_ID using psid-HeadStart_d1_parent.dta, keepusing(mom_*) keep(match master)
drop _merge
merge m:1 father_ID using psid-HeadStart_d1_parent.dta, keepusing(dad_*) keep(match master)
drop _merge

assert mom_female==1 | mom_female==.
assert dad_female==0 | dad_female==.

log close
set more on
