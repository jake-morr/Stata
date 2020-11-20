clear
set more off
capture log close
log using Stataproject2.log, replace
use E:\econ5813\usa_000001.dat\econ5813_acs_d1.dta 

*****************
*   Question 1  *
*****************
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

*B

generate female = .
replace female =1 if sex==2
replace female =0 if sex==1

*C

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

*D

generate exp = .
replace exp = ( ( age - schoolyr ) - 6 )

*E

generate private = .
generate govt = .
generate othermpt = .
replace govt = 0
replace govt = 1 if classwkrd == 25
replace govt = 1 if classwkrd == 27
replace govt = 1 if classwkrd == 28
replace private = 0
replace private = 1 if classwkrd == 22
replace othermpt = 0
replace othermpt = 1 if classwkrd == 13
replace othermpt = 1 if classwkrd == 14
replace othermpt = 1 if classwkrd == 23
replace othermpt = 1 if classwkrd == 29

*F

generate maried = .
replace maried = 1 if marst == 1
replace maried = 1 if marst == 2
replace maried = 0 if marst == 3
replace maried = 0 if marst == 4
replace maried = 0 if marst == 5
replace maried = 0 if marst == 6

*G
generate foreign = .
replace foreign = 0
replace foreign = 1 if bpl > 115



*I
gen hispanic = (hispand~=0 & hispand~=900)
gen black = (raced==200 & hispanic==0)
gen asian = (raced>=400 & raced<=699) & hispanic==0
gen native = (raced>=300 & raced<=399) & hispanic==0
gen white = (raced==100 & hispanic==0)
gen othrace = (hispanic==0 & black==0 & asian==0 & native==0 & white==0)
gen check = hispanic+black+asian+native+white+othrace
sum check
drop check

*J
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

***************
* Question 2  *
***************

*Check Word Document

**************
* Question 3 *
**************

*Check Word Document

**************
* Question 4 *
**************

*A
reg wage exp

*D
predict yhat
sum yhat
sum wage


**************
* Question 5 *
**************

*A
reg wage exp if female ==1
reg wage exp if female ==0

*D
generate expf = (exp * female)
regress wage exp female expf

**************
* Question 6 *
**************

sum age
gen age_centered = age-r(mean)
gen age_std =  (age-r(mean))/r(sd)
egen age_std2 = std(age)
assert age_std==age_std2

*i
gen age_f  = (age*female)
reg wage female age age_f

*ii
gen age_f_c = ( age_centered* female)
reg wage female age_centered age_f_c

*iii
generate age_std_f = ( age_std* female)
reg wage female age_std age_std_f

**************
* Question 7 *
**************

generate lnwage = ln(wage)
generate lnexp = ln(exp)

*i
reg lnwage schoolyr lnexp
*ii
reg lnwage schoolyr exp
*iii
reg wage schoolyr lnexp
*iiii
generate exp2 = (exp* exp)
reg wage schoolyr exp exp2

**************
* Question 8 *
**************

*A
reg wage exp female elem college ma phd
*B
reg wage exp female elem hs ma phd

**************
* Question 9 *
**************

generate elemf = (elem * female)
generate hsf = (hs * female)
generate collegef = (college * female)
generate maf = (ma * female)
generate phdf = (phd * female)
reg wage exp exp2 female elem college ma phd elemf collegef maf phdf

***************
* Question 10 *
***************
*1
reg schoolyr exp female
*2
predict e_hat, resid
sum e_hat
reg wage e_hat
*3
reg wage schoolyr exp female


set more on
log close




