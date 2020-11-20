capture log close
log using 6073_multistate.log, replace
set linesize 255
set more off
set varabbrev off


clear all
use Historical_3.dta

drop hhwt
drop perwt
drop gq

#delimit ;
keep if metarea == 24 | metarea == 60 | metarea == 112 | metarea == 152 | metarea == 512 
| metarea == 156 | metarea == 160 | metarea == 164 | metarea == 166 | metarea == 180
| metarea == 196 | metarea == 224 | metarea == 252 | metarea == 258 | metarea == 318
| metarea == 340 | metarea == 366 | metarea == 376 | metarea == 452 | metarea == 492
| metarea == 616 | metarea == 560 | metarea == 572 | metarea == 592 | metarea == 644
| metarea == 648 | metarea == 700 | metarea == 704 | metarea == 772 | metarea == 780
| metarea == 808 | metarea == 840 | metarea == 884 | metarea == 916 | metarea == 932
| metarea == 244
;
#delimit cr

