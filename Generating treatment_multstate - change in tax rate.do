capture log close
log using 6073_Cleaning_Historical_Data_MultiState2.log, replace
set linesize 255
set more off
set varabbrev off

clear all
use Historical_3_MultiState.dta


*gen labforce_partic =.
*replace labforce_partic = 0.5533 if year == 1960
*replace labforce_partic = 0.5550 if year == 1970
*replace labforce_partic = 0.619 if year == 1980
*replace labforce_partic = 0.646 if year == 1990
*replace labforce_partic = 0.6302 if year == 2000

*gen labforce_partic_f =.
*replace labforce_partic_f = .3452 if year == 1960
*replace labforce_partic_f = .3970 if year == 1970
*replace labforce_partic_f = .4988 if year == 1980
*replace labforce_partic_f = .5595 if year == 1990
*replace labforce_partic_f = .5658 if year == 2000

drop if labforce == 0




*gen labforce_partic_1960 = ((labforce_in) / (labforce_in + labforce_out)) if year == 1960 & statefip == 18

replace labforce = 0 if labforce == 1
replace labforce = 1 if labforce == 2

gen labforce_partic_1960 =0

sum labforce if year == 1960 & statefip == 10
replace labforce_partic_1960 = r(mean) if statefip == 10 & year == 1960

sum labforce if year == 1960 & statefip == 11
replace labforce_partic_1960 = r(mean) if statefip == 11 & year == 1960

sum labforce if year == 1960 & statefip == 13
replace labforce_partic_1960 = r(mean) if statefip == 13 & year == 1960

sum labforce if year == 1960 & statefip == 17
replace labforce_partic_1960 = r(mean) if statefip == 17 & year == 1960

sum labforce if year == 1960 & statefip == 18
replace labforce_partic_1960 = r(mean) if statefip == 18 & year == 1960

sum labforce if year == 1960 & statefip == 19
replace labforce_partic_1960 = r(mean) if statefip == 19 & year == 1960

sum labforce if year == 1960 & statefip == 20
replace labforce_partic_1960 = r(mean) if statefip == 20 & year == 1960

sum labforce if year == 1960 & statefip == 21
replace labforce_partic_1960 = r(mean) if statefip == 24 & year == 1960

sum labforce if year == 1960 & statefip == 25
replace labforce_partic_1960 = r(mean) if statefip == 25 & year == 1960

sum labforce if year == 1960 & statefip == 27
replace labforce_partic_1960 = r(mean) if statefip == 27 & year == 1960

sum labforce if year == 1960 & statefip == 29
replace labforce_partic_1960 = r(mean) if statefip == 29 & year == 1960

sum labforce if year == 1960 & statefip == 31
replace labforce_partic_1960 = r(mean) if statefip == 31 & year == 1960

sum labforce if year == 1960 & statefip == 34
replace labforce_partic_1960 = r(mean) if statefip == 34 & year == 1960

sum labforce if year == 1960 & statefip == 36
replace labforce_partic_1960 = r(mean) if statefip == 36 & year == 1960

sum labforce if year == 1960 & statefip == 37
replace labforce_partic_1960 = r(mean) if statefip == 37 & year == 1960

sum labforce if year == 1960 & statefip == 38
replace labforce_partic_1960 = r(mean) if statefip == 38 & year == 1960

sum labforce if year == 1960 & statefip == 39
replace labforce_partic_1960 = r(mean) if statefip == 39 & year == 1960

sum labforce if year == 1960 & statefip == 41
replace labforce_partic_1960 = r(mean) if statefip == 41 & year == 1960

sum labforce if year == 1960 & statefip == 42
replace labforce_partic_1960 = r(mean) if statefip == 42 & year == 1960

sum labforce if year == 1960 & statefip == 44
replace labforce_partic_1960 = r(mean) if statefip == 44 & year == 1960

sum labforce if year == 1960 & statefip == 45
replace labforce_partic_1960 = r(mean) if statefip == 45 & year == 1960

sum labforce if year == 1960 & statefip == 47
replace labforce_partic_1960 = r(mean) if statefip == 47 & year == 1960

sum labforce if year == 1960 & statefip == 51
replace labforce_partic_1960 = r(mean) if statefip == 51 & year == 1960

sum labforce if year == 1960 & statefip == 53
replace labforce_partic_1960 = r(mean) if statefip == 53 & year == 1960

gen labforce_partic_1970 =0

sum labforce if year == 1970 & statefip == 10
replace labforce_partic_1970 = r(mean) if statefip == 10 & year == 1970

sum labforce if year == 1970 & statefip == 11
replace labforce_partic_1970 = r(mean) if statefip == 11 & year == 1970

sum labforce if year == 1970 & statefip == 13
replace labforce_partic_1970 = r(mean) if statefip == 13 & year == 1970

sum labforce if year == 1970 & statefip == 17
replace labforce_partic_1970 = r(mean) if statefip == 17 & year == 1970

sum labforce if year == 1970 & statefip == 18
replace labforce_partic_1970 = r(mean) if statefip == 18 & year == 1970

sum labforce if year == 1970 & statefip == 19
replace labforce_partic_1970 = r(mean) if statefip == 19 & year == 1970

sum labforce if year == 1970 & statefip == 20
replace labforce_partic_1970 = r(mean) if statefip == 20 & year == 1970

sum labforce if year == 1970 & statefip == 21
replace labforce_partic_1970 = r(mean) if statefip == 24 & year == 1970

sum labforce if year == 1970 & statefip == 25
replace labforce_partic_1970 = r(mean) if statefip == 25 & year == 1970

sum labforce if year == 1970 & statefip == 27
replace labforce_partic_1970 = r(mean) if statefip == 27 & year == 1970

sum labforce if year == 1970 & statefip == 29
replace labforce_partic_1970 = r(mean) if statefip == 29 & year == 1970

sum labforce if year == 1970 & statefip == 31
replace labforce_partic_1970 = r(mean) if statefip == 31 & year == 1970

sum labforce if year == 1970 & statefip == 34
replace labforce_partic_1970 = r(mean) if statefip == 34 & year == 1970

sum labforce if year == 1970 & statefip == 36
replace labforce_partic_1970 = r(mean) if statefip == 36 & year == 1970

sum labforce if year == 1970 & statefip == 37
replace labforce_partic_1970 = r(mean) if statefip == 37 & year == 1970

sum labforce if year == 1970 & statefip == 38
replace labforce_partic_1970 = r(mean) if statefip == 38 & year == 1970

sum labforce if year == 1970 & statefip == 39
replace labforce_partic_1970 = r(mean) if statefip == 39 & year == 1970

sum labforce if year == 1970 & statefip == 41
replace labforce_partic_1970 = r(mean) if statefip == 41 & year == 1970

sum labforce if year == 1970 & statefip == 42
replace labforce_partic_1970 = r(mean) if statefip == 42 & year == 1970

sum labforce if year == 1970 & statefip == 44
replace labforce_partic_1970 = r(mean) if statefip == 44 & year == 1970

sum labforce if year == 1970 & statefip == 45
replace labforce_partic_1970 = r(mean) if statefip == 45 & year == 1970

sum labforce if year == 1970 & statefip == 47
replace labforce_partic_1970 = r(mean) if statefip == 47 & year == 1970

sum labforce if year == 1970 & statefip == 51
replace labforce_partic_1970 = r(mean) if statefip == 51 & year == 1970

sum labforce if year == 1970 & statefip == 53
replace labforce_partic_1970 = r(mean) if statefip == 53 & year == 1970

gen labforce_partic_1980 =0

sum labforce if year == 1980 & statefip == 10
replace labforce_partic_1980 = r(mean) if statefip == 10 & year == 1980

sum labforce if year == 1980 & statefip == 11
replace labforce_partic_1980 = r(mean) if statefip == 11 & year == 1980

sum labforce if year == 1980 & statefip == 13
replace labforce_partic_1980 = r(mean) if statefip == 13 & year == 1980

sum labforce if year == 1980 & statefip == 17
replace labforce_partic_1980 = r(mean) if statefip == 17 & year == 1980

sum labforce if year == 1980 & statefip == 18
replace labforce_partic_1980 = r(mean) if statefip == 18 & year == 1980

sum labforce if year == 1980 & statefip == 19
replace labforce_partic_1980 = r(mean) if statefip == 19 & year == 1980

sum labforce if year == 1980 & statefip == 20
replace labforce_partic_1980 = r(mean) if statefip == 20 & year == 1980

sum labforce if year == 1980 & statefip == 21
replace labforce_partic_1980 = r(mean) if statefip == 24 & year == 1980

sum labforce if year == 1980 & statefip == 25
replace labforce_partic_1980 = r(mean) if statefip == 25 & year == 1980

sum labforce if year == 1980 & statefip == 27
replace labforce_partic_1980 = r(mean) if statefip == 27 & year == 1980

sum labforce if year == 1980 & statefip == 29
replace labforce_partic_1980 = r(mean) if statefip == 29 & year == 1980

sum labforce if year == 1980 & statefip == 31
replace labforce_partic_1980 = r(mean) if statefip == 31 & year == 1980

sum labforce if year == 1980 & statefip == 34
replace labforce_partic_1980 = r(mean) if statefip == 34 & year == 1980

sum labforce if year == 1980 & statefip == 36
replace labforce_partic_1980 = r(mean) if statefip == 36 & year == 1980

sum labforce if year == 1980 & statefip == 37
replace labforce_partic_1980 = r(mean) if statefip == 37 & year == 1980

sum labforce if year == 1980 & statefip == 38
replace labforce_partic_1980 = r(mean) if statefip == 38 & year == 1980

sum labforce if year == 1980 & statefip == 39
replace labforce_partic_1980 = r(mean) if statefip == 39 & year == 1980

sum labforce if year == 1980 & statefip == 41
replace labforce_partic_1980 = r(mean) if statefip == 41 & year == 1980

sum labforce if year == 1980 & statefip == 42
replace labforce_partic_1980 = r(mean) if statefip == 42 & year == 1980

sum labforce if year == 1980 & statefip == 44
replace labforce_partic_1980 = r(mean) if statefip == 44 & year == 1980

sum labforce if year == 1980 & statefip == 45
replace labforce_partic_1980 = r(mean) if statefip == 45 & year == 1980

sum labforce if year == 1980 & statefip == 47
replace labforce_partic_1980 = r(mean) if statefip == 47 & year == 1980

sum labforce if year == 1980 & statefip == 51
replace labforce_partic_1980 = r(mean) if statefip == 51 & year == 1980

sum labforce if year == 1980 & statefip == 53
replace labforce_partic_1980 = r(mean) if statefip == 53 & year == 1980

sum labforce if year == 1980 & statefip == 5
replace labforce_partic_1980 = r(mean) if statefip == 5 & year == 1980


sum labforce if year == 1980 & statefip == 26
replace labforce_partic_1980 = r(mean) if statefip == 26 & year == 1980

sum labforce if year == 1980 & statefip == 54
replace labforce_partic_1980 = r(mean) if statefip == 54 & year == 1980

gen labforce_partic_1990 =0

sum labforce if year == 1990 & statefip == 10
replace labforce_partic_1990 = r(mean) if statefip == 10 & year == 1990

sum labforce if year == 1990 & statefip == 11
replace labforce_partic_1990 = r(mean) if statefip == 11 & year == 1990

sum labforce if year == 1990 & statefip == 13
replace labforce_partic_1990 = r(mean) if statefip == 13 & year == 1990

sum labforce if year == 1990 & statefip == 17
replace labforce_partic_1990 = r(mean) if statefip == 17 & year == 1990

sum labforce if year == 1990 & statefip == 18
replace labforce_partic_1990 = r(mean) if statefip == 18 & year == 1990

sum labforce if year == 1990 & statefip == 19
replace labforce_partic_1990 = r(mean) if statefip == 19 & year == 1990

sum labforce if year == 1990 & statefip == 20
replace labforce_partic_1990 = r(mean) if statefip == 20 & year == 1990

sum labforce if year == 1990 & statefip == 21
replace labforce_partic_1990 = r(mean) if statefip == 24 & year == 1990

sum labforce if year == 1990 & statefip == 25
replace labforce_partic_1990 = r(mean) if statefip == 25 & year == 1990

sum labforce if year == 1990 & statefip == 27
replace labforce_partic_1990 = r(mean) if statefip == 27 & year == 1990

sum labforce if year == 1990 & statefip == 29
replace labforce_partic_1990 = r(mean) if statefip == 29 & year == 1990

sum labforce if year == 1990 & statefip == 31
replace labforce_partic_1990 = r(mean) if statefip == 31 & year == 1990

sum labforce if year == 1990 & statefip == 34
replace labforce_partic_1990 = r(mean) if statefip == 34 & year == 1990

sum labforce if year == 1990 & statefip == 36
replace labforce_partic_1990 = r(mean) if statefip == 36 & year == 1990

sum labforce if year == 1990 & statefip == 37
replace labforce_partic_1990 = r(mean) if statefip == 37 & year == 1990

sum labforce if year == 1990 & statefip == 38
replace labforce_partic_1990 = r(mean) if statefip == 38 & year == 1990

sum labforce if year == 1990 & statefip == 39
replace labforce_partic_1990 = r(mean) if statefip == 39 & year == 1990

sum labforce if year == 1990 & statefip == 41
replace labforce_partic_1990 = r(mean) if statefip == 41 & year == 1990

sum labforce if year == 1990 & statefip == 42
replace labforce_partic_1990 = r(mean) if statefip == 42 & year == 1990

sum labforce if year == 1990 & statefip == 44
replace labforce_partic_1990 = r(mean) if statefip == 44 & year == 1990

sum labforce if year == 1990 & statefip == 45
replace labforce_partic_1990 = r(mean) if statefip == 45 & year == 1990

sum labforce if year == 1990 & statefip == 47
replace labforce_partic_1990 = r(mean) if statefip == 47 & year == 1990

sum labforce if year == 1990 & statefip == 51
replace labforce_partic_1990 = r(mean) if statefip == 51 & year == 1990

sum labforce if year == 1990 & statefip == 53
replace labforce_partic_1990 = r(mean) if statefip == 53 & year == 1990

sum labforce if year == 1990 & statefip == 5
replace labforce_partic_1990 = r(mean) if statefip == 5 & year == 1990

sum labforce if year == 1990 & statefip == 54
replace labforce_partic_1990 = r(mean) if statefip == 54 & year == 1990

gen labforce_partic_2000 =0

sum labforce if year == 2000 & statefip == 10
replace labforce_partic_2000 = r(mean) if statefip == 10 & year == 2000

sum labforce if year == 2000 & statefip == 11
replace labforce_partic_2000 = r(mean) if statefip == 11 & year == 2000

sum labforce if year == 2000 & statefip == 13
replace labforce_partic_2000 = r(mean) if statefip == 13 & year == 2000

sum labforce if year == 2000 & statefip == 17
replace labforce_partic_2000 = r(mean) if statefip == 17 & year == 2000

sum labforce if year == 2000 & statefip == 18
replace labforce_partic_2000 = r(mean) if statefip == 18 & year == 2000

sum labforce if year == 2000 & statefip == 19
replace labforce_partic_2000 = r(mean) if statefip == 19 & year == 2000

sum labforce if year == 2000 & statefip == 20
replace labforce_partic_2000 = r(mean) if statefip == 20 & year == 2000

sum labforce if year == 2000 & statefip == 21
replace labforce_partic_2000 = r(mean) if statefip == 24 & year == 2000

sum labforce if year == 2000 & statefip == 25
replace labforce_partic_2000 = r(mean) if statefip == 25 & year == 2000

sum labforce if year == 2000 & statefip == 27
replace labforce_partic_2000 = r(mean) if statefip == 27 & year == 2000

sum labforce if year == 2000 & statefip == 29
replace labforce_partic_2000 = r(mean) if statefip == 29 & year == 2000

sum labforce if year == 2000 & statefip == 31
replace labforce_partic_2000 = r(mean) if statefip == 31 & year == 2000

sum labforce if year == 2000 & statefip == 34
replace labforce_partic_2000 = r(mean) if statefip == 34 & year == 2000

sum labforce if year == 2000 & statefip == 36
replace labforce_partic_2000 = r(mean) if statefip == 36 & year == 2000

sum labforce if year == 2000 & statefip == 37
replace labforce_partic_2000 = r(mean) if statefip == 37 & year == 2000

sum labforce if year == 2000 & statefip == 38
replace labforce_partic_2000 = r(mean) if statefip == 38 & year == 2000

sum labforce if year == 2000 & statefip == 39
replace labforce_partic_2000 = r(mean) if statefip == 39 & year == 2000

sum labforce if year == 2000 & statefip == 41
replace labforce_partic_2000 = r(mean) if statefip == 41 & year == 2000

sum labforce if year == 2000 & statefip == 42
replace labforce_partic_2000 = r(mean) if statefip == 42 & year == 2000

sum labforce if year == 2000 & statefip == 44
replace labforce_partic_2000 = r(mean) if statefip == 44 & year == 2000

sum labforce if year == 2000 & statefip == 45
replace labforce_partic_2000 = r(mean) if statefip == 45 & year == 2000

sum labforce if year == 2000 & statefip == 47
replace labforce_partic_2000 = r(mean) if statefip == 47 & year == 2000

sum labforce if year == 2000 & statefip == 51
replace labforce_partic_2000 = r(mean) if statefip == 51 & year == 2000

sum labforce if year == 2000 & statefip == 53
replace labforce_partic_2000 = r(mean) if statefip == 53 & year == 2000

gen labforce_partic = labforce_partic_1960 + labforce_partic_1970 + labforce_partic_1980 + labforce_partic_1990 + labforce_partic_2000

replace labforce = 2 if labforce == 1
replace labforce = 1 if labforce == 0





drop if empstatd == 13 | empstatd == 14 | empstatd == 15 | empstatd == 0 | empstatd == 30
drop if labforce == 1
drop if workedyr == 1 | workedyr == 2
drop if pwstate1 == 0 | pwstate1 == 9
drop if statefip == 99
drop if pwstate2 == 99
drop if pwstate2 == 0



gen check =.
gen check2 =.

replace check = 1 if pwstate1 ==. & year == 1970
replace check2 = 1 if pwstate2 ==. & year == 1970

drop if check== 1

gen commute =.
replace commute = 1 if pwstate2 ~= statefip & pwstate2 ~=. & pwstate2 ~= 99 & statefip ~= 99
replace commute = 1 if pwstate1 == 2 | pwstate1 == 3
replace commute = 0 if pwstate1 == 1
replace commute = 0 if pwstate2 == statefip

*drop if metaread == 8840



gen incwage_2019 =.
replace incwage_2019 = (incwage * 8.674) if year ==1960
replace incwage_2019 = (incwage * 6.618) if year ==1970
replace incwage_2019 = (incwage * 3.116) if year ==1980
replace incwage_2019 = (incwage * 1.964) if year ==1990
replace incwage_2019 = (incwage * 1.491) if year ==2000

gen inctot_2019 =.
replace inctot_2019 = (inctot * 8.674) if year ==1960
replace inctot_2019 = (inctot * 6.618) if year ==1970
replace inctot_2019 = (inctot * 3.116) if year ==1980
replace inctot_2019 = (inctot * 1.964) if year ==1990
replace inctot_2019 = (inctot * 1.491) if year ==2000



*#delimit ;

*replace treatment = 1 if metaread == 240 | metaread == 720 | metaread == 870
*| metaread == 1604 | metaread == 1640 | metaread == 1960 | metaread == 2240
*  | metaread == 2320 | metaread == 2440 | metaread == 2520 | metaread == 2760
*   | metaread == 3180 | metaread == 3400 | metaread == 3620 | metaread == 3800
*    | metaread == 4000 | metaread == 4520 | metaread == 4720 | metaread == 5120
*	 | metaread == 6160 | metaread == 6280 | metaread == 6880 | metaread == 7610
*	  | metaread == 7800 | metaread == 8080 | metaread == 8400 | metaread == 8480
*	   | metaread == 8760 | metaread == 9320 | metaread == 6820 | metaread == 6800
*	   ;
*#delimit cr

*drop if metaread == 2520

drop if metarea == 884

generate post = 0

generate year_rta = 0

generate treatment = 0

replace post = (.0005 * inctot_2019) if metarea == 24 & year == 1980 & statefip == 42
replace post = (.0065 * inctot_2019) if metarea == 24 & year == 1990 & statefip == 42
replace post = (.01085 * inctot_2019) if metarea == 24 & year == 2000 & statefip == 42
replace year_rta = 1980 if metarea == 24
replace treatment = 1 if metarea == 24
replace post = (0.006 * inctot_2019) if metarea == 160 & year == 1980 & statefip == 17
replace post = (0.004 * inctot_2019) if metarea == 160 & year == 1990 & statefip == 18
replace post = (0.004 * inctot_2019) if metarea == 160 & year == 2000 & statefip == 18
replace year_rta = 1980 if metarea == 160
replace treatment = 1 if metarea == 160
*replace post = 1 if metaread == 720 & year >= 1991
*replace post = 1 if metaread == 870 & year >= 1968
replace post = (.02 * inctot_2019) if metarea == 164 & year == 1980 & statefip == 39
replace post = (0.0018 * inctot_2019) if metarea == 164 & year == 1990 & statefip == 39
replace post = (0.00165 * inctot_2019) if metarea == 164 & year == 2000 & statefip == 39
replace year_rta = 1980 if metarea == 164
replace treatment = 1 if metarea == 164
replace post = (0.0425 * inctot_2019) if metarea == 196 & year == 1980 & statefip == 17
replace post = (.0219 * inctot_2019) if metarea == 196 & year == 1990 & statefip == 17
replace year_rta = 1980 if metarea == 196
replace treatment = 1 if metarea == 196
*replace post = -1.67 if metarea == 196 & year == 2000 & statefip == 17
*replace post = -0.4 if metarea == 224 & year == 1970 & statefip == 55
*replace post = -2.1 if metarea == 224 & year == 1980 & statefip == 55
*replace post = -1.085 if metarea == 224 & year == 1990 & statefip == 55
*replace post = -1.26 if metarea == 224 & year == 2000 & statefip == 55
*replace post = 1 if metaread == 2320 & year >= 1968
replace post = (0.021 * inctot_2019) if metarea == 244 & year == 1980 & statefip == 18
replace post = (0.006 * inctot_2019) if metarea == 244 & year == 1990 & statefip == 18
replace post = (0.006 * inctot_2019) if metarea == 244 & year == 2000 & statefip == 18
replace year_rta = 1980 if metarea == 244
replace treatment = 1 if metarea == 244
*replace post = 1 if metaread == 2760 & year >= 1977
replace post = (.0075 * inctot_2019) if metarea == 318 & year == 1990 & statefip == 24
replace post = (.0075 * inctot_2019) if metarea == 318 & year == 2000 & statefip == 24
replace year_rta = 1990 if metarea == 318
replace treatment = 1 if metarea == 318
*replace post = 2.625 if metarea == 340 & year == 1970 Come back
*replace post = 2.85 if metarea == 340 & year == 1980 Come back
*replace post = 0.84 if metarea == 340 & year == 1990 Come back
*replace post = 0.8325 if metarea == 340 & year == 2000 Come back
*replace post = 1 if metaread == 3620 & year >= 1973
*replace post = 1 if metaread == 3800 & year >= 1973
*replace post = 1 if metaread == 4000 & year >= 1991
*replace post = -3.95 if metarea == 452 & year == 1980 & statefip == 18
replace post = (.0135 * inctot_2019) if metarea == 452 & year == 1990 & statefip == 18
replace year_rta = 1990 if metarea == 452
replace treatment = 1 if metarea == 452
*replace post = -1.35 if metarea == 452 & year == 2000 & statefip == 18
*replace post = 1 if metaread == 4720 & year >= 1973
*replace post = -0.4 if metarea == 512 & year == 1970 & statefip ~= 27
*replace post = -2.1 if metarea == 512 & year == 1980 & statefip ~= 27
*replace post = -1.085 if metarea == 512 & year == 1990 & statefip ~= 27
*replace post = -1.26 if metarea == 512 & year == 2000 & statefip ~= 27
replace post = (0.0005 * inctot_2019) if metarea == 616 & year == 1980 & statefip == 42
replace post = (0.0065 * inctot_2019) if metarea == 616 & year == 1990 & statefip == 42
replace post = (.01085 * inctot_2019) if metarea == 616 & year == 2000 & statefip == 42
replace year_rta = 1980 if metarea == 616
replace treatment = 1 if metarea == 616
*replace post = 1 if metaread == 6280 & year >= 1972
*replace post = 1 if metaread == 6800 & year >= 1988
*replace post = 1 if metaread == 6820 & year >= 1968
*replace post = 1 if metaread == 6880 & year >= 1973
*replace post = 1 if metaread == 7610 & year >= 1978
replace post = (0.006 * inctot_2019) if metarea == 780 & year == 1970 & statefip == 18
replace post = (.027 * inctot_2019) if metarea == 780 & year == 1980 & statefip == 18
replace post = (.012 * inctot_2019) if metarea == 780 & year == 1990 & statefip == 18
replace post = (0.009 * inctot_2019) if metarea == 780 & year == 2000 & statefip == 18
replace year_rta = 1970 if metarea == 780
replace treatment = 1 if metarea == 780
*replace post = 1 if metarea == 808 & year >= 1972
replace post = (.026 * inctot_2019) if metarea == 840 & year == 1980 & statefip == 39
replace year_rta = 1980 if metarea == 840
replace treatment = 1 if metarea == 840
*replace post = -0.78 if metarea == 840 & year == 1990 & statefip == 39
*replace post = -0.465 if metarea == 840 & year == 2000 & statefip == 39
*replace post = 1 if metaread == 8480 & year >= 1978
*replace post = 1 if metaread == 8760 & year >= 1978
replace post = (0.002 * inctot_2019) if metarea == 932 & year == 1980 & statefip == 39
replace year_rta = 1980 if metarea == 932
replace treatment = 1 if metarea == 932
*replace post = -1.72 if metarea == 932 & year == 1990 & statefip ~= 39
*replace post = -1.035 if metarea == 932 & year == 2000 & statefip ~= 39
*replace post = 1 if metarea == 252 & year >= 1969

gen complete = 0
replace complete = 1 if metarea == 24
replace complete = 1 if metarea == 112
replace complete = 1 if metarea == 152
replace complete = 1 if metarea == 160
replace complete = 1 if metarea == 164
replace complete = 1 if metarea == 376
replace complete = 1 if metarea == 452
replace complete = 1 if metarea == 492
replace complete = 1 if metarea == 512
replace complete = 1 if metarea == 560
replace complete = 1 if metarea == 572
replace complete = 1 if metarea == 592
replace complete = 1 if metarea == 616
replace complete = 1 if metarea == 644
replace complete = 1 if metarea == 648
replace complete = 1 if metarea == 704
replace complete = 1 if metarea == 840
replace complete = 1 if metarea == 932

generate lead3 = 0
replace lead3 = 1 if year == (year_rta - 30) & commute ~=.
generate lead2 = 0
replace lead2 = 1 if year == (year_rta - 20) & commute ~=.
generate lead1 = 0
replace lead1 = 1 if year == (year_rta - 10) & commute ~=.
generate lead0 = 0
replace lead0 = 1 if year == year_rta & commute ~=.
generate lag3 = 0
replace lag3 = 1 if year == (year_rta + 30) & commute ~=.
generate lag2 = 0
replace lag2 = 1 if year == (year_rta + 20) & commute ~=.
generate lag1 = 0
replace lag1 = 1 if year == (year_rta + 10) & commute ~=.


*drop if sample == 197002
drop if inctot <=0
drop if year == 2001
rename metarea msa
drop if wkswork2 <=2

generate move = 0
replace move = 1 if migrate5 == 3




gen did = (treatment * post)

gen ln_commute = ln(commute)



