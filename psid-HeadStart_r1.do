****************************
*** psid-HeadStart_r1.do ***
****************************

#delimit ;

capture log close;
log using psid-HeadStart_reg1.log, replace;
set linesize 255;
set more off;
set varabbrev off;

clear all;
use psid-HeadStart_d3.dta;


*****************************************************************;
*** Replication of Garces, Thomas, Currie (2002) Regressions  ***;
*****************************************************************;
set matsize 200;
**************************************************;
*** Make linear spline in log income variables ***;
**************************************************;


mkspline f_ln_earnings3_6_spline 4 = f_ln_earnings3_6 , pctile display;
 
 sum f_ln_earnings3_6, detail;


*******************;
*** Regressions ***;
*******************;

***********************************************************************************************************************************************************;


*column 1 all respondents;
reg highschool_2015 headstart preschool birthyear female white;
reg somecollege_2015 headstart preschool birthyear female white;
reg ln_earnings2328 headstart preschool female white;
reg crime headstart preschool female white;

*column 2 sibling sample;
reg highschool_2015 headstart preschool birthyear female white if SiblingSample ==1;
reg somecollege_2015 birthyear female white if SiblingSample ==1;
reg ln_earnings2328 headstart preschool birthyear female white if SiblingSample ==1;
reg crime headstart preschool female white if SiblingSample ==1;

*column 3 Control Variables;
reg highschool_2015 headstart preschool birthyear female white mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW;
reg somecollege_2015 headstart preschool birthyear female white mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW ;
reg ln_earnings2328 headstart preschool birthyear female white mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW;
reg crime headstart preschool mom_edyrs birthyear female white dad_edyrs dad_edyrs_imputed mom_edyrs_imputed f_familysize4 i_birthorder firstborn LBW;

*Column 4 ;

xtset mother_ID;

xtreg highschool_2015 headstart preschool birthyear female white mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3, fe;
xtreg somecollege_2015 headstart preschool birthyear female white mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3, fe;
xtreg ln_earnings2328 headstart preschool birthyear female white mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3,fe ;
xtreg crime headstart preschool birthyear female white mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3, fe;

*column 5;

xtreg highschool_2015 headstart preschool birthyear female mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3 if black_race ==1, fe;
xtreg somecollege_2015 headstart preschool birthyear female mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3 if black_race ==1, fe;
xtreg ln_earnings2328 headstart preschool birthyear female mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3 if black_race ==1, fe ;
xtreg crime headstart preschool birthyear female mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3 if black_race ==1, fe;


*column 6;
xtreg highschool_2015 headstart preschool birthyear female mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3 if white_race ==1, fe;
xtreg somecollege_2015 headstart preschool birthyear female mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3 if white_race ==1, fe;
xtreg ln_earnings2328 headstart preschool birthyear female mom_edyrs mom_edyrs_imputed dad_edyrs dad_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3 if white_race ==1, fe ;
xtreg crime headstart preschool birthyear female mom_edyrs dad_edyrs dad_edyrs_imputed mom_edyrs_imputed f_familysize4 i_birthorder firstborn LBW f_ln_earnings3_6_spline1 f_ln_earnings3_6_spline2 f_ln_earnings3_6_spline3 if white_race ==1, fe;

log close;
set more on;

