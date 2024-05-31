*Import data
clear all

import delimited "D:\CSMAR data\dataProcessing\city\extraADM2.csv"

*set panel
xtset id year

*Generate logged GDP and NTL
gen gdppc = gdpct01 / eect01
gen bmpc = bm / eect01
gen bmmeanpc = bmmean / eect01
gen bmmedianpc = bmmedian / eect01
gen viirslpc = viirsl / eect01


gen lngdppc = log(gdppc*10000)
gen lnbmpc = log(bmpc*10000)
gen lnbmmeanpc = log(bmmeanpc*10000)
gen lnbmmedianpc = log(bmmedianpc*10000)
gen lnviirslpc = log(viirsl*100000)
gen lnviirslpc2 = log(viirslmean*100000)
summarize

*Black Marble
reg lngdppc lnbmpc
outreg2 using "tab01-1.tex", replace keep(lngdppc lnbmpc) ctitle(Pooled OLS) addstat(R2,e(r2),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnbmpc, be 
outreg2 using "tab01-1.tex", append keep(lngdppc lnbmpc) ctitle(Between Estimator) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnbmpc i.year, fe robust
outreg2 using "tab01-1.tex", append keep(lngdppc lnbmpc) ctitle(TW Fixed Effect) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*Black Marble Mean
reg lngdppc lnbmmeanpc
outreg2 using "tab01-1.tex", append keep(lngdppc lnbmmeanpc) ctitle(Pooled OLS) addstat(R2,e(r2),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnbmmeanpc, be 
outreg2 using "tab01-1.tex", append keep(lngdppc lnbmmeanpc) ctitle(Between Estimator) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnbmmeanpc i.year, fe robust
outreg2 using "tab01-1.tex", append keep(lngdppc lnbmmeanpc) ctitle(TW Fixed Effect) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*Black Marble Median
reg lngdppc lnbmmedianpc
outreg2 using "tab01-1.tex", append keep(lngdppc lnbmmedianpc) ctitle(Pooled OLS) addstat(R2,e(r2),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnbmmedianpc, be 
outreg2 using "tab01-1.tex", append keep(lngdppc lnbmmedianpc) ctitle(Between Estimator) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
xtreg lngdppc lnbmmedianpc i.year, fe robust
outreg2 using "tab01-1.tex", append keep(lngdppc lnbmmedianpc) ctitle(TW Fixed Effect) addstat(R2,e(r2_o),RMSE,e(rmse)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons noni nor2

*VIIRS-like
reg lngdppc lnviirslpc
outreg2 using "tab01-1.tex", append keep(lngdppc lnviirslpc) ctitle(Pooled OLS) addstat(R2,e(r2),RMSE,e(rmse)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons noni nor2
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