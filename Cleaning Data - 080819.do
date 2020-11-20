capture log close
log using 6073_Cleaning_Data.log, replace
set linesize 255
set more off
set varabbrev off

clear all
use ACS_Download.dta

********Key********
* 27 = Minnesota  *
* 55 = Wisconsin  *
*******************

*****************************************
                                        *
** Droping Uneccesary Variables **      *
                                        *
*****************************************

drop hhwt
drop cntry
drop mortgage
drop mortgag2
drop vacancy
drop perwt
drop mbpl
drop mbpld
drop fbpl
drop fbpld
drop gq
drop if year == 1970

******************************************
                                         *
** Droping States not of interest        *
                                         *
										 *
******************************************

* variables I want to keep
* statefip = Minesota or Wisconsin
* migplac1
* 

keep if statefip == 27 | statefip == 55 | migplac1 == 27 | migplac1 == 55



gen commute = .
replace commute = 1 if statefip != pwstate2 & pwstate2 != 0
replace commute = 0 if statefip == pwstate2


gen wisconsin_border = 0
replace wisconsin_border = 1 if statefip == 55 & puma == 100
replace wisconsin_border = 1 if statefip == 55 & puma == 55101
replace wisconsin_border = 1 if statefip == 55 & puma == 55102
replace wisconsin_border = 1 if statefip == 55 & puma == 400
replace wisconsin_border = 1 if statefip == 55 & puma == 700
replace wisconsin_border = 1 if statefip == 55 & puma == 800
replace wisconsin_border = 1 if statefip == 55 & puma == 900

generate wisconsin_minnesota = 0
replace wisconsin_minnesota = 1 if statefip == 55 & pwstate2 == 27

generate minnesota_wisconsin = 0
replace minnesota_wisconsin = 1 if statefip == 27 & pwstate2 == 55

gen minnesota_border = 0
replace minnesota_border = 1 if statefip == 27 & puma == 500
replace minnesota_border = 1 if statefip == 27 & puma == 600
replace minnesota_border = 1 if statefip == 27 & puma == 900
replace minnesota_border = 1 if statefip == 27 & puma == 1202
replace minnesota_border = 1 if statefip == 27 & puma == 1203
replace minnesota_border = 1 if statefip == 27 & puma == 1502
replace minnesota_border = 1 if statefip == 27 & puma == 1700
replace minnesota_border = 1 if statefip == 27 & puma == 2100
replace minnesota_border = 1 if statefip == 27 & puma == 2200
replace minnesota_border = 1 if statefip == 27 & puma == 2300
replace minnesota_border = 1 if statefip == 27 & puma == 2600











set more on



