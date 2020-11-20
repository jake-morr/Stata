******************************
*** psid-HeadStart_sum2.do ***
******************************

capture log close
log using psid-HeadStart_sum2.log, replace
set linesize 255
set more off
set varabbrev off

clear all
use psid-HeadStart_d3.dta

************************************************************************
*** Replication of Garces, Thomas, Currie (2002) Summary Statistics  ***
************************************************************************

******************************************
*** Table 1: Summary Statistics (full) ***
******************************************

#delimit ;
   global Table1_vars "headstart preschool
                       highschool_1995 somecollege_1995
                       earnings2325
                       crime black female i_age_1995 firstborn LBW
                       mom_edyrs mom_highschool
                       dad_edyrs dad_highschool
                       f_earnings3_6
                       mom_single f_familysize4";

foreach var of varlist $Table1_vars {;
   clonevar `var'_100 = `var';
   replace  `var'_100 = `var'*100;
};

   global Table1_vars_100 "headstart_100 preschool_100
                           highschool_1995_100 somecollege_1995_100
                           earnings2325 crime_100
                           black_100 female_100 i_age_1995
                           firstborn_100 LBW_100
                           mom_edyrs mom_highschool_100
                           dad_edyrs dad_highschool_100
                           f_earnings3_6
                           mom_single_100 f_familysize4
                           ";
						   
tabstat $Table1_vars_100, by(headstart) stat(n mean sd) col(stats) longstub;
tabstat $Table1_vars_100 if SiblingSample == 1, stat(n mean sd) col(stats) longstub;

log close
set more on
