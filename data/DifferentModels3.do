*Import data
clear all

import delimited "D:\CSMAR data\dataProcessing\county\ADM3_version2.csv"

*set panel
xtset id year

*Generate logged GDP and NTL
gen gdppc = reggdp / popnum
gen bmpc = bm / popnum
gen ccnlpc = ccnl / popnum
gen hdmsppc = hdmsp / popnum
gen hviirspc = hviirs / popnum
gen viirsv1pc = viirsv1 / popnum
gen viirsv2pc = viirsv2 / popnum
gen viirslpc = viirsl / popnum
gen egdppc = egdp / popnum

gen lngdppc = log(gdppc*10000)
gen lnbmpc = log(bmpc*10000)
gen lnccnlpc = log(ccnlpc*10000)
gen lnhdmsppc = log(hdmsppc*10000)
gen lnhviirspc = log(hviirspc*10000)
gen lnviirsv1pc = log(viirsv1pc*10000)
gen lnviirsv2pc = log(viirsv2pc*10000)
gen lnviirslpc = log(viirsl*10000)
gen lnegdppc = log(egdppc*10000)

summarize

*BLack Marble
xtreg gdppc bmpc i.year, fe robust
outreg2 using "tab04.tex", replace keep(gdppc bmpc) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdppc c.bmpc##c.bmpc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc c.bmpc##c.bmpc) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdppc lnbmpc i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdppc lnbmpc) ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*CCNL
xtreg gdppc ccnlpc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc ccnlpc) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdppc c.ccnlpc##c.ccnlpc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc c.ccnlpc##c.ccnlpc) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdppc lnccnlpc i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdppc lnccnlpc) ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*Harmonized DMSP
xtreg gdppc hdmsppc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc hdmsppc) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdppc c.hdmsppc##c.hdmsppc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc c.hdmsppc##c.hdmsppc) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdppc lnhdmsppc i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdppc lnhdmsppc) ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*Harmonized VIIRS
xtreg gdppc hviirspc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc hviirspc) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdppc c.hviirspc##c.hviirspc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc c.hviirspc##c.hviirspc) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdppc lnhviirspc i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdppc lnhviirspc) ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*VIIRS Version 1
xtreg gdppc viirsv1pc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc viirsv1pc) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdppc c.viirsv1pc##c.viirsv1pc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc c.viirsv1pc##c.viirsv1pc) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdppc lnviirsv1pc i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdppc lnviirsv1pc)ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*VIIRS Version 2
xtreg gdppc viirsv2pc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc viirsv2pc) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdppc c.viirsv2pc##c.viirsv2pc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc c.viirsv2pc##c.viirsv2pc) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdppc lnviirsv2pc i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdppc lnviirsv2pc)ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*VIIRS-like
xtreg gdppc viirslpc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc viirslpc) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdppc c.viirslpc##c.viirslpc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc c.viirslpc##c.viirslpc) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdppc lnviirslpc i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdppc lnviirslpc) ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*Electricity Consumption revised GDP
xtreg gdppc egdppc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc egdppc) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdppc c.egdppc##c.egdppc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc c.egdppc##c.egdppc) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdppc lnegdppc i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdppc lnegdppc) ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2