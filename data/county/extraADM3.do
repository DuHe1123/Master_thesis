*Import data
clear all

import delimited "D:\CSMAR data\dataProcessing\county\extraADM3.csv"

*set panel
xtset id year

*Generate logged GDP and NTL
gen gdppc = reggdp / popnum
gen viirslpc = viirsl / popnum


gen lngdppc = log(gdppc*10000)
gen lnviirslpc = log(viirsl*10000)
gen lnviirslpc2 = log(viirslmean*10000)
summarize

*VIIRS-like
reg lngdppc lnviirslpc
outreg2 using "tab01-1.tex", replace keep(lngdppc lnviirslpc) ctitle(Pooled OLS) addstat(R2,e(r2),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnviirslpc, be
outreg2 using "tab01-1.tex", append keep(lngdppc lnviirslpc) ctitle(Between Estimator) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnviirslpc i.year, fe robust
outreg2 using "tab01-1.tex", append keep(lngdppc lnviirslpc) ctitle(TW Fixed Effect) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*VIIRS-like by mean()
reg lngdppc lnviirslpc2
outreg2 using "tab01-1.tex", append keep(lngdppc lnviirslpc2) ctitle(Pooled OLS) addstat(R2,e(r2),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnviirslpc2, be
outreg2 using "tab01-1.tex", append keep(lngdppc lnviirslpc2) ctitle(Between Estimator) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnviirslpc2 i.year, fe robust
outreg2 using "tab01-1.tex", append keep(lngdppc lnviirslpc2) ctitle(TW Fixed Effect) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2