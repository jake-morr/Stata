******************************
*** psid-HeadStart_sum1.do ***
******************************

capture log close
log using psid-HeadStart_sum1.log, replace
set linesize 255
set more off
set varabbrev off

clear all
use psid-HeadStart_d2.dta

************************************************************************
*** Replication of Garces, Thomas, Currie (2002) Summary Statistics  ***
************************************************************************

*********************************************
*** Table 1: Summary Statistics (partial) ***
*********************************************

#delimit ;
   global Table1_vars "headstart preschool 
                       highschool_1995 somecollege_1995
                       crime black female i_age_1995";
#delimit cr;

tabstat $Table1_vars, by(headstart) stat(N mean semean sd min max) long col(stat)

tabstat $Table1_vars if SiblingSample == 1, stat(N mean semean sd min max) long col(stat)

log close
set more on

