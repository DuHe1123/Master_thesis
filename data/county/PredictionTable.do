clear all

*Import data
cd "D:\Github Desktop\Master_thesis\data\county"
use "CleanData.dta", replace

xtset id year 


*Total NTL v.s. Total GDP
reg lngdp lnvl
outreg2 using "tab03.tex", replace keep(lngdp lnvl) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lngdp lnvl, be
outreg2 using "tab03.tex", append keep(lngdp lnvl) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2 
reghdfe lngdp lnvl, absorb(citycode year) cluster(citycode)
outreg2 using "tab03.tex", append keep(lngdp lnvl) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons nor2 noni

*Total NTL v.s. Total GDP
reg lnnpgdp lnvl_urban
outreg2 using "tab03.tex", append keep(lnnpgdp lnvl_urban) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lnnpgdp lnvl_urban, be
outreg2 using "tab03.tex", append keep(lnnpgdp lnvl_urban) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2 
reghdfe lnnpgdp lnvl_urban, absorb(citycode year) cluster(citycode)
outreg2 using "tab03.tex", append keep(lnnpgdp lnvl_urban) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons nor2 noni

*NPP v.s. AgriGDP
reg lnpgdp lnnpp
outreg2 using "tab03.tex", append keep(lnpgdp lnnpp) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lnpgdp lnnpp, be
outreg2 using "tab03.tex", append keep(lnpgdp lnnpp) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2 
reghdfe lnpgdp lnnpp, absorb(citycode year) cluster(citycode)
outreg2 using "tab03.tex", append keep(lnpgdp lnnpp) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons nor2 noni

*mean NTL v.s. GDP pc
reg lngdppc lnvlpc
outreg2 using "tab03.tex", append keep(lngdppc lnvlpc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lngdppc lnvlpc, be
outreg2 using "tab03.tex", append keep(lngdppc lnvlpc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2 
reghdfe lngdppc lnvlpc, absorb(citycode year) cluster(citycode)
outreg2 using "tab03.tex", append keep(lngdppc lnvlpc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons nor2 noni