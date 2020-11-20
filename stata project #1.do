clear
set more off
capture log close
log using "stata project 1", replace
use E:\econ5813\usa_000001.dat\econ5813_acs_d1.dta 



*3a
describe
compress
describe
*3b
list age sex state if _n<=20
*3c
sort state age
*3d
list age sex state if _n<=20
*3e
list age state incwage if sex==2 in 1/30
*4a
clear
use E:\econ5813\usa_000001.dat\econ5813_acs_d1.dta
drop empstatd
*4b
generate weeksworked = .
replace weeksworked = 7 if wkswork2==1
replace weeksworked = 20 if wkswork2==2
replace weeksworked = 33 if wkswork2==3
replace weeksworked = 43.5 if wkswork2==4
replace weeksworked = 48.5 if wkswork2==5
replace weeksworked = 51 if wkswork2==6
*4c
drop if weeksworked <=26
*4f
generate female =1 if sex==2
replace female =0 if sex ==1
generate male =0 if sex==1
replace male =1 if sex==2
*4h
tab female male
*5b
generate wage = (( incwage* uhrswork)/ weeksworked)
*5c
sum wage
*5d
sum wage if age <= 30
*6a
sum wage if sex==1
*hypo test
*7a
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
*7b
reg wage schoolyr
*7c
reg wage schoolyr age
*7d
gen schoolyr2 = schoolyr* schoolyr
gen age2 = age* age
reg wage schoolyr schoolyr2 age age2
*7e
reg wage schoolyr schoolyr2 age age2 if male==0
reg wage schoolyr schoolyr2 age age2 if male==1
*7f
generate schoolyr_12 = schoolyr-12
generate age_20 = ln(age-20)
generate sxa = schoolyr_12* age_20
reg schoolyr_12 age_20 sxa
*8
reg wag schoolyr age










set more on
log close
