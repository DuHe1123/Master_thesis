*Import data
clear all

import delimited "D:\CSMAR data\dataProcessing\county\mergedWithClass.csv"

*set panel
xtset id year

*Generate logged GDP and NTL
gen lngdp = ln(reggdp*10000)
gen lnpgdp = ln(reggdp_primary*10000)
gen lnsgdp = ln(reggdp_secondary*10000)
gen lntgdp = ln(reggdp_tertiary*10000)

gen lnviirsl = ln(viirsl*10000)
gen lntnl = ln(total_sol*10000)
gen lnanl = ln(agriculture_sol*10000)
gen lnunl = ln(urban_sol*10000)

summarize

*Total vs total
reg lngdp lntnl
outreg2 using "tab01.tex", replace keep(lngdp lntnl) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lngdp lntnl, be
outreg2 using "tab01.tex", append keep(lngdp lntnl) ctitle(Between Estimator) addstat(R2_o,e(r2_o)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lngdp lntnl i.year, fe robust
outreg2 using "tab01.tex", append keep(lngdp lntnl) ctitle(TW Fixed Effect) addstat(R2_o,e(r2_o)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons nor2 noni 

*Agriculture vs primary
reg lnpgdp lnanl 
outreg2 using "tab01.tex", append keep(lnpgdp lnanl) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lnpgdp lnanl, be
outreg2 using "tab01.tex", append keep(lnpgdp lnanl) ctitle(Between Estimator) addstat(R2_o,e(r2_o)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lnpgdp lnanl i.year, fe robust
outreg2 using "tab01.tex", append keep(lnpgdp lnanl) ctitle(TW Fixed Effect) addstat(R2_o,e(r2_o)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons nor2 noni 

*Urban vs secondary
reg lnsgdp lnunl 
outreg2 using "tab01.tex", append keep(lnsgdp lnunl) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lnsgdp lnunl, be
outreg2 using "tab01.tex", append keep(lnsgdp lnunl) ctitle(Between Estimator) addstat(R2_o,e(r2_o)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lnsgdp lnunl i.year, fe robust
outreg2 using "tab01.tex", append keep(lnsgdp lnunl) ctitle(TW Fixed Effect) addstat(R2_o,e(r2_o)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons nor2 noni 
*Urban vs tertiary
reg lntgdp lnunl 
outreg2 using "tab01.tex", append keep(lntgdp lnunl) ctitle(Pooled OLS) addstat(R2_o,e(r2)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lntgdp lnunl, be
outreg2 using "tab01.tex", append keep(lntgdp lnunl) ctitle(Between Estimator) addstat(R2_o,e(r2_o)) addtext(Regional FE, NO, Year FE, NO) dec(3) label nocons nor2
xtreg lntgdp lnunl i.year, fe robust
outreg2 using "tab01.tex", append keep(lntgdp lnunl) ctitle(TW Fixed Effect) addstat(R2_o,e(r2_o)) addtext(Regional FE, YES, Year FE, YES) dec(3) label nocons nor2 noni 

*Predict total
xtreg lngdp lntnl i.year, fe robust
predict plngdp
xtreg lngdp plngdp i.year, fe robust

*Predict by sector
quietly xtreg lnpgdp lnanl i.year, fe robust
predict plnpgdp
quietly xtreg lnsgdp lnunl i.year, fe robust
predict plnsgdp
quietly xtreg lntgdp lnunl i.year, fe robust
predict plntgdp
gen nlngdp = plnpgdp + plnsgdp + plntgdp

xtreg lngdp lntnl i.year, fe robust
xtreg lngdp nlngdp i.year, fe robust