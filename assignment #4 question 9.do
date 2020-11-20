clear
set more off
capture log close
log using assignment#4.log, replace
use E:\econ5813\usa_000001.dat\econ5813_acs_d1.dta 


**************
* Question 9 *
**************

*A
generate weeksworked = .
replace weeksworked = 7 if wkswork2==1
replace weeksworked = 20 if wkswork2==2
replace weeksworked = 33 if wkswork2==3
replace weeksworked = 43.5 if wkswork2==4
replace weeksworked = 48.5 if wkswork2==5
replace weeksworked = 51 if wkswork2==6
drop if weeksworked <=26
generate wage = (( incwage/uhrswork)/weeksworked)
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
gen lnschoolyr = log(schoolyr)
generate exp = .
replace exp = ( ( age - schoolyr ) - 6 )
generate femaleexp = ( female* exp)
generate exp2 = (exp*exp)
generate femaleexp2 = ( femaleexp* femaleexp)
generate maried = .
replace maried = 1 if marst == 1
replace maried = 1 if marst == 2
replace maried = 0 if marst == 3
replace maried = 0 if marst == 4
replace maried = 0 if marst == 5
replace maried = 0 if marst == 6


reg wage exp exp2 femaleexp femaleexp2

*B
generate femalemarried = (female*maried)
reg wage exp exp2 schoolyr femalemarried femaleexp femaleexp2

*C
reg wage exp exp2 femaleexp femaleexp2 schoolyr
test exp = schoolyr

*D
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
gen age_25 = (age-25)
generate age_25m = (age_25*maried)
reg wage schoolyr age_25 maried age_25m if female==0

*E
generate exp_10 = exp/10
reg wage elem college ma phd exp_10
test college = exp_10

set more on
log close



