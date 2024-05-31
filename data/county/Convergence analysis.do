clear all

*Import Weight Matrix
cd "D:\Github Desktop\Master_thesis\dataProcessing\county"
use "W_matrix2.dta", replace
gen id = _n
order id, first
spset id
spmatrix fromdata WqueenS = v*, normalize(row) replace
spmatrix summarize WqueenS





*Import data
use "ADM3egdp.dta", replace
drop if citycode == 460300
egen id = group(countycode)
xtset countycode year
order id year
xtsum

*Specify central, western and eastern regions
gen location = 1 if provincecode == 140000 | provincecode== 340000 | provincecode == 360000 | provincecode == 410000 | provincecode == 420000 | provincecode == 430000

replace location = 2 if provincecode == 150000 | provincecode== 450000 | provincecode == 500000 | provincecode == 510000 | provincecode == 520000 | provincecode == 530000 | provincecode == 540000 | provincecode == 610000 | provincecode == 620000 | provincecode == 630000 | provincecode == 640000 | provincecode == 650000

replace location = 3 if provincecode == 110000 | provincecode== 120000 | provincecode == 130000| provincecode == 310000 | provincecode ==320000| provincecode == 330000 | provincecode ==350000| provincecode == 370000 | provincecode ==440000| provincecode == 460000

replace location = 4 if provincecode == 210000 | provincecode== 220000 | provincecode == 230000 

label define location_label 1 "Central" 2 "Western" 3 "Eastern" 4 "Northeastern"
label values location location_label

*Prepare the data
drop if year >= 2020

*replace perreggdp = reggdp / (popnum * 10000) if missing(perreggdp)
*gen lngdp = ln(perreggdp + 1)
*gen lnvl = ln(vl3m + 1)

*xtreg lngdp lnvl i.year i.provincecode // approach 2
*predict xb, xb
*predict u, u
*replace u = 0 if missing(u)
*gen plngdp = xb + u

*Take log
gen gdp = ln(egdp3m*100)

*Reshape
drop egdp3m
reshape wide gdp, i(id) j(year)

*Generate GDP growth rate
gen gdpgr = ((gdp2019 / gdp1992) - 1) *100

xtset, clear
spset id









*Global
*OLS
reg gdpgr gdp1992
estimate store OLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*Moran's I
quietly reg gdpgr gdp1992
estat moran, errorlag(WqueenS)

*SAR
spregress gdpgr gdp1992, ml dvarlag(WqueenS)
eststo SAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress gdpgr gdp1992, ml errorlag(WqueenS)
eststo SEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress gdpgr gdp1992, ml ivarlag(WqueenS: gdp1992)
eststo SLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress gdpgr gdp1992, ml dvarlag(WqueenS) ivarlag(WqueenS: gdp1992)
eststo SDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab OLS SAR SEM SLX SDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.3f)

*Wald test
*Reduce to OLS?
spregress gdpgr gdp1992, ml dvarlag(WqueenS) ivarlag(WqueenS: gdp1992)

*Reduce to SLX?
test ([WqueenS]gdpgr = 0)

*Reduce to SAR?
test ([WqueenS]gdp1992 = 0)

*Reduce to SEM?
testnl ([WqueenS]gdp1992 = -[WqueenS]gdpgr*[gdpgr]gdp1992)








*Central
*OLS
reg gdpgr gdp1992 if location == 1
estimate store cOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*SAR
spregress gdpgr gdp1992 if location == 1, ml dvarlag(WqueenS) force
eststo cSAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress gdpgr gdp1992 if location == 1, ml errorlag(WqueenS) force
eststo cSEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress gdpgr gdp1992 if location == 1, ml ivarlag(WqueenS: gdp1992) force
eststo cSLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress gdpgr gdp1992 if location == 1, ml dvarlag(WqueenS) ivarlag(WqueenS: gdp1992) force
eststo cSDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab cOLS cSAR cSEM cSLX cSDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.3f)








*Western
*OLS
reg gdpgr gdp1992 if location == 2
estimate store wOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*SAR
spregress gdpgr gdp1992 if location == 2, ml dvarlag(WqueenS) force
eststo wSAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress gdpgr gdp1992 if location == 2, ml errorlag(WqueenS) force
eststo wSEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress gdpgr gdp1992 if location == 2, ml ivarlag(WqueenS: gdp1992) force
eststo wSLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress gdpgr gdp1992 if location == 2, ml dvarlag(WqueenS) ivarlag(WqueenS: gdp1992) force
eststo wSDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab wOLS wSAR wSEM wSLX wSDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.3f)







*Eastern
*OLS
reg gdpgr gdp1992 if location == 3
estimate store eOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*SAR
spregress gdpgr gdp1992 if location == 3, ml dvarlag(WqueenS) force
eststo eSAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress gdpgr gdp1992 if location == 3, ml errorlag(WqueenS) force
eststo eSEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress gdpgr gdp1992 if location == 3, ml ivarlag(WqueenS: gdp1992) force
eststo eSLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress gdpgr gdp1992 if location == 3, ml dvarlag(WqueenS) ivarlag(WqueenS: gdp1992) force
eststo eSDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab eOLS eSAR eSEM eSLX eSDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.3f)







*Northeastern
*OLS
reg gdpgr gdp1992 if location == 4
estimate store neOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*SAR
spregress gdpgr gdp1992 if location == 4, ml dvarlag(WqueenS) force
eststo neSAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress gdpgr gdp1992 if location == 4, ml errorlag(WqueenS) force
eststo neSEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress gdpgr gdp1992 if location == 4, ml ivarlag(WqueenS: gdp1992) force
eststo neSLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress gdpgr gdp1992 if location == 4, ml dvarlag(WqueenS) ivarlag(WqueenS: gdp1992) force
eststo neSDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab neOLS neSAR neSEM neSLX neSDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.3f)


*Turn tables into Latex code
esttab SAR SEM using tables.tex, ///
    cells(b(star fmt(%9.3f)) se(par fmt(%9.3f)) AIC(fmt(%9.2f) label("AIC")) ) ///
    varlabels(_cons Constant) ///
    label nodepvars nonumbers replace

*Scatterfit
scatterfit gdpgr gdp2000, ci vce(robust) regparameters(coef sig pval r2 nobs) parpos(60 6)

scatterfit gdpgr gdp1992, vce(robust) regparameters(coef sig pval r2 nobs) parpos(60 6) by(location)

