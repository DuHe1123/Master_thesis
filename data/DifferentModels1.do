*Import data
clear all

import delimited "D:\CSMAR data\dataProcessing\province\ADM1"

*set panel
xtset regionid year

*Generate logged GDP and NTL
gen gdp = gdp0101
gen lngdp = ln(gdp0101*1000000)
gen lnccnl = ln(ccnl1s*1000000)
gen lne = ln(e1s*1000000)
gen lnegdp = ln(egdp1s*1000000)
gen lnhdmsp = ln(hdmsp1s*1000000)
gen lnhviirs = ln(hviirs1s*1000000)
gen lnpanda = ln(panda1s*1000000)
gen lnviirs = ln(viirs1s*1000000)
gen lnvl = ln(vl1s*1000000)

summarize


*BLack Marble
xtreg gdppc bmpc i.year, fe robust
outreg2 using "tab04.tex", replace keep(gdppc bmpc) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdppc c.bmpc##c.bmpc i.year, fe robust
outreg2 using "tab04.tex", append keep(gdppc c.bmpc##c.bmpc) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdppc lnbmpc i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdppc lnbmpc) ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*CCNL
xtreg gdp ccnl1s i.year, fe robust
outreg2 using "tab04.tex", append keep(gdp ccnl1s) ctitle(Model1) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg gdp c.ccnl1s##c.ccnl1s i.year, fe robust
outreg2 using "tab04.tex", append keep(gdp c.ccnl1s##c.ccnl1s) ctitle(Model2) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2
xtreg lngdp lnccnl i.year, fe robust
outreg2 using "tab04.tex", append keep(lngdp lnccnl) ctitle(Model3) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

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




*Generate logged GDP and NTL pc
gen lngdppc = ln(gdp0116*1000000)
gen lnccnlpc = ln(ccnl1m*1000000)
gen lnepc = ln(e1m*1000000)
gen lnegdppc = ln(egdp1m*1000000)
gen lnhdmsppc = ln(hdmsp1m*1000000)
gen lnhviirspc = ln(hviirs1m*1000000)
gen lnpandapc = ln(panda1m*1000000)
gen lnviirspc = ln(viirs1m*1000000)
gen lnvlpc = ln(vl1m*1000000)

