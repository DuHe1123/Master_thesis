*Import data
clear all

import delimited "D:\Github Desktop\Master_thesis\data\city\ADM2.csv"

*set panel
xtset regionid year

/// Validation of total sum of lights to total GDP

*Generate logged GDP and NTL
gen lngdp = ln(gdpct01*1000000)
gen lnccnl = ln(ccnl2s*1000000)
gen lne = ln(e2s*1000000)
gen lnegdp = ln(egdp2s*1000000)
gen lnhdmsp = ln(hdmsp2s*1000000)
gen lnhviirs = ln(hviirs2s*1000000)
gen lnpanda = ln(panda2s*1000000)
gen lnviirs = ln(viirs2s*1000000)
gen lnvl = ln(vl2s*1000000)

summarize

*CCNL
reg lngdp lnccnl if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", replace keep(lngdp lnccnl) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, CCNL) dec(3) label nocons nor2
xtreg lngdp lnccnl, be, if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnccnl) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, CCNL) dec(3) label nocons nor2
reghdfe lngdp lnccnl, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnccnl) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, CCNL) dec(3) label nocons nor2 noni

*Harmonized DMSP
reg lngdp lnhdmsp if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnhdmsp) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, HDMSP) dec(3) label nocons nor2
xtreg lngdp lnhdmsp, be, if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnhdmsp) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, HDMSP) dec(3) label nocons nor2
reghdfe lngdp lnhdmsp, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnhdmsp) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, HDMSP) dec(3) label nocons nor2 noni

*Electricity Consumption P1
reg lngdp lne if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lne) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, ECP1) dec(3) label nocons nor2
xtreg lngdp lne, be, if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lne) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, ECP1) dec(3) label nocons nor2
reghdfe lngdp lne, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lne) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, ECP1) dec(3) label nocons nor2 noni

*Electricity Consumption Revised GDP P1
reg lngdp lnegdp if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnegdp) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, EGDPP1) dec(3) label nocons nor2
xtreg lngdp lnegdp, be, if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnegdp) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, EGDPP1) dec(3) label nocons nor2
reghdfe lngdp lnegdp, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnegdp) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, EGDPP1) dec(3) label nocons nor2 noni

*PANDA P1
reg lngdp lnpanda if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnpanda) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, PANDAP1) dec(3) label nocons nor2
xtreg lngdp lnpanda, be, if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnpanda) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, PANDAP1) dec(3) label nocons nor2
reghdfe lngdp lnpanda, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnpanda) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, PANDAP1) dec(3) label nocons nor2 noni 

*VIIRS-like P1
reg lngdp lnvl if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnvl) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSLP1) dec(3) label nocons nor2
xtreg lngdp lnvl, be, if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnvl) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSLP1) dec(3) label nocons nor2
reghdfe lngdp lnvl, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab01.tex", append keep(lngdp lnvl) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, VIIRSLP1) dec(3) label nocons nor2 noni 

*Electricity Consumption P2
reg lngdp lne if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lne) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, ECP2) dec(3) label nocons nor2
xtreg lngdp lne, be, if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lne) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, ECP2) dec(3) label nocons nor2
reghdfe lngdp lne, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lne) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, ECP2) dec(3) label nocons nor2 noni

*Electricity Consumption Revised GDP P2
reg lngdp lnegdp if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnegdp) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, EGDPP2) dec(3) label nocons nor2
xtreg lngdp lnegdp, be, if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnegdp) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, EGDPP2) dec(3) label nocons nor2
reghdfe lngdp lnegdp, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnegdp) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, EGDPP2) dec(3) label nocons nor2 noni

*PANDA P2
reg lngdp lnpanda if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnpanda) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, PANDAP2) dec(3) label nocons nor2
xtreg lngdp lnpanda, be, if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnpanda) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, PANDAP2) dec(3) label nocons nor2
reghdfe lngdp lnpanda, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnpanda) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, PANDAP2) dec(3) label nocons nor2 noni

*VIIRS-like P2
reg lngdp lnvl if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnvl) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSLP2) dec(3) label nocons nor2
xtreg lngdp lnvl, be, if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnvl) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSLP2) dec(3) label nocons nor2
reghdfe lngdp lnvl, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnvl) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, VIIRSLP2) dec(3) label nocons nor2 noni

*Harmonized VIIRS
reg lngdp lnhviirs if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnhviirs) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, HVIIRS) dec(3) label nocons nor2
xtreg lngdp lnhviirs, be, if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnhviirs) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, HVIIRS) dec(3) label nocons nor2
reghdfe lngdp lnhviirs, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnhviirs) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, HVIIRS) dec(3) label nocons nor2 noni

*VIIRS Version2
reg lngdp lnviirs if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnviirs) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSV2) dec(3) label nocons nor2
xtreg lngdp lnviirs, be, if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnviirs) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSV2) dec(3) label nocons nor2
reghdfe lngdp lnviirs, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab01.tex", append keep(lngdp lnviirs) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, VIIRSV2) dec(3) label nocons nor2 noni
















/// Validation of mean of lights to GDP per capita

*Generate logged GDP and NTL pc
gen lngdppc = ln(gdp_percapita*1000000)
gen lnccnlpc = ln(ccnl2m*1000000)
gen lnepc = ln(e2m*1000000)
gen lnegdppc = ln(egdp2m*1000000)
gen lnhdmsppc = ln(hdmsp2m*1000000)
gen lnhviirspc = ln(hviirs2m*1000000)
gen lnpandapc = ln(panda2m*1000000)
gen lnviirspc = ln(viirs2m*1000000)
gen lnvlpc = ln(vl2m*1000000)

*CCNL
reg lngdppc lnccnlpc if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", replace keep(lngdppc lnccnlpc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, CCNL) dec(3) label nocons nor2
xtreg lngdppc lnccnlpc, be, if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnccnlpc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, CCNL) dec(3) label nocons nor2
reghdfe lngdp lnccnlpc, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnccnlpc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, CCNL) dec(3) label nocons nor2 noni

*Harmonized DMSP
reg lngdppc lnhdmsppc if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnhdmsppc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, HDMSP) dec(3) label nocons nor2
xtreg lngdppc lnhdmsppc, be, if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnhdmsppc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, HDMSP) dec(3) label nocons nor2
reghdfe lngdp lnhdmsppc, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnhdmsppc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, HDMSP) dec(3) label nocons nor2 noni

*Electricity Consumption P1
reg lngdppc lnepc if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnepc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, ECP1) dec(3) label nocons nor2
xtreg lngdppc lnepc, be, if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnepc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, ECP1) dec(3) label nocons nor2
reghdfe lngdp lnepc, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnepc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, ECP1) dec(3) label nocons nor2 noni

*Electricity Consumption Revised GDP P1
reg lngdppc lnegdppc if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnegdppc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, EGDPP1) dec(3) label nocons nor2
xtreg lngdppc lnegdppc, be, if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnegdppc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, EGDPP1) dec(3) label nocons nor2
reghdfe lngdp lnegdppc, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnegdppc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, EGDPP1) dec(3) label nocons nor2 noni

*PANDA P1
reg lngdppc lnpandapc if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnpandapc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, PANDAP1) dec(3) label nocons nor2
xtreg lngdppc lnpandapc, be, if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnpandapc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, PANDAP1) dec(3) label nocons nor2
reghdfe lngdp lnpandapc, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnpandapc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, PANDAP1) dec(3) label nocons nor2 noni 

*VIIRS-like P1
reg lngdppc lnvlpc if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnvlpc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSLP1) dec(3) label nocons nor2
xtreg lngdppc lnvlpc, be, if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnvlpc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSLP1) dec(3) label nocons nor2
reghdfe lngdp lnvlpc, absorb(regionid year) cluster(regionid), if year >= 2000 & year <= 2012
outreg2 using "tab02.tex", append keep(lngdppc lnvlpc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, VIIRSLP1) dec(3) label nocons nor2 noni 

*Electricity Consumption P2
reg lngdppc lnepc if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnepc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, ECP2) dec(3) label nocons nor2
xtreg lngdppc lnepc, be, if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnepc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, ECP2) dec(3) label nocons nor2
reghdfe lngdp lnepc, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnepc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, ECP2) dec(3) label nocons nor2 noni

*Electricity Consumption Revised GDP P2
reg lngdppc lnegdppc if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnegdppc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, EGDPP2) dec(3) label nocons nor2
xtreg lngdppc lnegdppc, be, if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnegdppc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, EGDPP2) dec(3) label nocons nor2
reghdfe lngdp lnegdppc, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnegdppc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, EGDPP2) dec(3) label nocons nor2 noni

*PANDA P2
reg lngdppc lnpandapc if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnpandapc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, PANDAP2) dec(3) label nocons nor2
xtreg lngdppc lnpandapc, be, if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnpandapc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, PANDAP2) dec(3) label nocons nor2
reghdfe lngdp lnpandapc, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnpandapc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, PANDAP2) dec(3) label nocons nor2 noni

*VIIRS-like P2
reg lngdppc lnvlpc if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnvlpc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSLP2) dec(3) label nocons nor2
xtreg lngdppc lnvlpc, be, if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnvlpc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSLP2) dec(3) label nocons nor2
reghdfe lngdp lnvlpc, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnvlpc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, VIIRSLP2) dec(3) label nocons nor2 noni

*Harmonized VIIRS
reg lngdppc lnhviirspc if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnhviirspc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, HVIIRS) dec(3) label nocons nor2
xtreg lngdppc lnhviirspc, be, if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnhviirspc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, HVIIRS) dec(3) label nocons nor2
reghdfe lngdp lnhviirspc, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnhviirspc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, HVIIRS) dec(3) label nocons nor2 noni

*VIIRS Version2
reg lngdppc lnviirspc if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnviirspc) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSV2) dec(3) label nocons nor2
xtreg lngdppc lnviirspc, be, if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnviirspc) ctitle(Between Estimator) addstat(R2_b,e(r2_b)) addtext(Regional FE, NO, Year FE, NO, NTL, VIIRSV2) dec(3) label nocons nor2
reghdfe lngdp lnviirspc, absorb(regionid year) cluster(regionid), if year >= 2013 & year <= 2019
outreg2 using "tab02.tex", append keep(lngdppc lnviirspc) ctitle(TW Fixed Effect) addstat(R2_o,e(r2),R2_w,e(r2_within)) addtext(Regional FE, YES, Year FE, YES, NTL, VIIRSV2) dec(3) label nocons nor2 noni

