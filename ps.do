capture log close
log using development_ps.log, replace
set linesize 255
set more off
set varabbrev off

clear all
use supas.dta

********************
*Part I. Eductation*
********************
*1.

reg lhwage yeduc

*2.

tab high, missing

sum yeduc if high == 1 & old == 1 | high == 1 & veryold == 1
sum yeduc if high == 1 & young == 1 | high == 1 & intermed == 1 

*Create table and calculate difference

*3.

sum yeduc if high == 1 & young == 1 | high == 1 & intermed == 1
sum yeduc if high == 0 & young == 1 | high == 0 & intermed == 1

*Create table and calculate difference

*4. See Word Document

************************************************
*IV with a dummy instrument: the Wald Estimator*
************************************************

generate treatment =.
generate post =.

replace post = 1 if young == 1

replace post = 0 if old == 1

replace treatment = 1 if high == 1

replace treatment = 0 if high == 0

generate did = treatment*post

reg yeduc post treatment did

*Interpret results

*6.

*reduced form regression on wages

reg lhwage post treatment did

*7. See Word Document

*8(?)

***************************************************************************
*Two-stage least squares (2SLS): Young vs Old with fill regional variation*
***************************************************************************

*9.

generate voi =.
replace voi = prog_int*ROB

reg yeduc post treatment did voi young i.YOB i.ROB i.YOB##c.ch71

*10.

reg lhwage post treatment did voi young i.YOB i.ROB i.YOB##c.ch71

*11.

reg yeduc post treatment did voi young i.YOB i.ROB i.YOB##c.ch71

predict did_iv

reg lhwage did_iv young i.YOB i.ROB i.YOB##c.ch71

*12.

generate b62 = 0
replace b62 = 1 if YOB == 62

generate b63 = 0
replace b63 = 1 if YOB == 63

generate b64 = 0
replace b64 = 1 if YOB == 64

generate b65 = 0
replace b65 = 1 if YOB == 65

generate b66 = 0
replace b66 = 1 if YOB == 66

generate b67 = 0
replace b67 = 1 if YOB == 67

generate b68 = 0
replace b68 = 1 if YOB == 68

generate b69 = 0
replace b69 = 1 if YOB == 69

generate b70 = 0
replace b70 = 1 if YOB == 70

generate b71 = 0
replace b71 = 1 if YOB == 71

generate b72 = 0
replace b72 = 1 if YOB == 72


generate b62_intense = b62 * high

generate b63_intense = b63 * high

generate b64_intense = b64 * high

generate b65_intense = b65 * high

generate b66_intense = b66 * high

generate b67_intense = b67 * high

generate b68_intense = b68 * high

generate b69_intense = b69 * high

generate b70_intense = b70 * high

generate b71_intense = b71 * high

generate b72_intense = b72 * high

sum b62_intense b63_intense b64_intense b65_intense b66_intense b67_intense b68_intense b69_intense b70_intense b71_intense b72_intense

reg yeduc b62_intense b63_intense b64_intense b65_intense b66_intense b67_intense b68_intense b69_intense b70_intense b71_intense b72_intense i.YOB i.ROB

*13.

predict educ

reg lhwage educ 

*14.

*See Word document

*15.

*See Word document

*16.

reg lhwage educ i.YOB i. ROB
