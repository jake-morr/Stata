clear
set more off
capture log close
log using "econ 5803 hw 2", replace
use E:\Macro\pwt90

keep cgdpe pop ck year country countrycode
keep if year==2010
gen ypop = cgdpe/pop
gen kpop = ck/pop
gen _ypop_USA = ypop if countrycode=="USA"
by year, sort: egen ypop_USA = mean(_ypop_USA)
gen ypop_rel = ypop/ypop_USA
gen _kpop_USA = kpop if countrycode=="USA"
by year, sort: egen kpop_USA = mean(_kpop_USA)
gen kpop_rel = kpop/kpop_USA

local alpha=1/3
local eta=0.21875 
local gamma=1/2
			
gen ypred_rel = kpop_rel^(`alpha')
label variable ypred_rel "Prediction Cobb-Douglas (A=1)"
			
gen ypred2_rel = (`gamma'*(kpop_rel)^`eta' + (1-`gamma'))^(1/`eta')
label variable ypred2_rel "Prediction CES (A=1)"

gen A = ypop_rel/ypred_rel
gen ln_A = ln(A)
label variable ln_A "Cobb-Douglas (TFP)"
			
			
gen A2 = ((ypop_rel^`eta' - (1-`gamma'))/(`gamma'*kpop_rel^`eta'))^(1/`eta')
gen ln_A2 = ln(A2)
label variable ln_A2 "CES (Capital Augmenting)"
			
gen A3 = ypop_rel/ypred2_rel
gen ln_A3 = ln(A3)
label variable ln_A3 "CES (TFP)"
			
gen A4 = (ypop_rel/ypred2_rel)^(1/`alpha')
gen ln_A4 = ln(A4)
label variable ln_A4 "Cobb-Douglas (Capital Augmenting)"

local lvars "ypop ypred ypred2 kpop"
			foreach v of local lvars {
			
				gen ln_`v'_rel = ln(`v'_rel) //take the natural log of each variable in the list above
			}
			
			label variable ln_ypred_rel "Prediction Cobb-Douglas (A=1)"
			label variable ln_ypred2_rel "Prediction CES (A=1)"
			

set more on
log close
