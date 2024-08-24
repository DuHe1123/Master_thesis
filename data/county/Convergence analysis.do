clear all

*Import Weight Matrix
cd "D:\Github Desktop\Master_thesis\data\county"
use "Wqueen_rs.dta", replace
gen id = _n
order id, first
spset id
spmatrix fromdata WqueenS = v*, replace
spmatrix summarize WqueenS





*Import data
use "CleanData.dta", replace

keep if year == 2001 | year == 2021

*Reshape
keep id year county countycode city citycode province provincecode plngdppc urbanland urbanland_share cropland cropland_share popden urbanization nonagri_share location

reshape wide plngdppc urbanland urbanland_share cropland cropland_share popden urbanization nonagri_share, i(id) j(year)

*Generate GDP growth rate
*gen gdpgr = (plngdppc2021 - plngdppc2001) / 20
gen gdpgr = (plngdppc2021 - plngdppc2001)

xtset, clear
spset id

*spatgsa gdp1992, weights(WqueenS) moran

*Compute global moran's I
*spatwmat using "W_matrix2.dta", name(W) standardize
*spatgsa gdp1992, weights(W) moran

global ylist gdpgr
global xlist plngdppc2001 popden2001 nonagri_share2001  urbanization2001


*Global
*OLS
reg $ylist plngdppc2001
estimate store iOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

reg $ylist $xlist
estimate store OLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*Moran's I
quietly reg $ylist $xlist
estat moran, errorlag(WqueenS)

*SAR
spregress $ylist $xlist, ml dvarlag(WqueenS)
eststo SAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress $ylist $xlist, ml errorlag(WqueenS)
eststo SEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress $ylist $xlist, ml ivarlag(WqueenS: $xlist)
eststo SLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress $ylist $xlist, ml dvarlag(WqueenS) ivarlag(WqueenS: $xlist)
eststo SDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab OLS SAR SEM SLX SDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.5f)


esttab iOLS OLS SAR SEM SLX SDM using "Total.tex",replace ///
cells(b(star fmt(%9.3f)) se(par)) ///
label stats(ll aic bic N, fmt(%9.1f) labels("Log likelihood" "AIC" "BIC" "Observations")) ///
title("Regression Results") ///
mtitle("OLS" "OLS" "SAR" "SEM" "SLX" "SDM") ///
star(* 0.10 ** 0.05 *** 0.01)

*Wald test
*Reduce to OLS?
*spregress $ylist $xlist, ml dvarlag(WqueenS) ivarlag(WqueenS: $xlist)

*Reduce to SLX?
*test ([WqueenS]$xlist = 0)

*Reduce to SAR?
*test ([WqueenS]$ylist = 0)

*Reduce to SEM?
*testnl ([WqueenS]$xlist = -[WqueenS]$ylist*[$ylist]$xlist)








*Central
*OLS
reg $ylist plngdppc2001 if location == 1
estimate store ciOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

reg $ylist $xlist if location == 1
estimate store cOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*SAR
spregress $ylist $xlist if location == 1, ml dvarlag(WqueenS) force
eststo cSAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress $ylist $xlist if location == 1, ml errorlag(WqueenS) force
eststo cSEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress $ylist $xlist if location == 1, ml ivarlag(WqueenS: $xlist) force
eststo cSLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress $ylist $xlist if location == 1, ml dvarlag(WqueenS) ivarlag(WqueenS: $xlist) force
eststo cSDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab cOLS cSAR cSEM cSLX cSDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.3f)


esttab ciOLS cOLS cSAR cSEM cSLX cSDM using "Central.tex",replace ///
cells(b(star fmt(%9.3f)) se(par)) ///
label stats(ll aic bic N, fmt(%9.1f) labels("Log likelihood" "AIC" "BIC" "Observations")) ///
title("Regression Results") ///
mtitle("OLS" "OLS" "SAR" "SEM" "SLX" "SDM") ///
star(* 0.10 ** 0.05 *** 0.01)





*Western
*OLS
reg $ylist plngdppc2001 if location == 2
estimate store wiOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

reg $ylist $xlist if location == 2
estimate store wOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*SAR
spregress $ylist $xlist if location == 2, ml dvarlag(WqueenS) force
eststo wSAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress $ylist $xlist if location == 2, ml errorlag(WqueenS) force
eststo wSEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress $ylist $xlist if location == 2, ml ivarlag(WqueenS: $xlist) force
eststo wSLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress $ylist $xlist if location == 2, ml dvarlag(WqueenS) ivarlag(WqueenS: $xlist) force
eststo wSDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab wOLS wSAR wSEM wSLX wSDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.3f)


esttab wiOLS wOLS wSAR wSEM wSLX wSDM using "Western.tex",replace ///
cells(b(star fmt(%9.3f)) se(par)) ///
label stats(ll aic bic N, fmt(%9.1f) labels("Log likelihood" "AIC" "BIC" "Observations")) ///
title("Regression Results") ///
mtitle("OLS" "OLS" "SAR" "SEM" "SLX" "SDM") ///
star(* 0.10 ** 0.05 *** 0.01)




*Eastern
*OLS
reg $ylist plngdppc2001 if location == 3
estimate store eiOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

reg $ylist $xlist if location == 3
estimate store eOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*SAR
spregress $ylist $xlist if location == 3, ml dvarlag(WqueenS) force
eststo eSAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress $ylist $xlist if location == 3, ml errorlag(WqueenS) force
eststo eSEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress $ylist $xlist if location == 3, ml ivarlag(WqueenS: $xlist) force
eststo eSLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress $ylist $xlist if location == 3, ml dvarlag(WqueenS) ivarlag(WqueenS: $xlist) force
eststo eSDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab eOLS eSAR eSEM eSLX eSDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.3f)

esttab eiOLS eOLS eSAR eSEM eSLX eSDM using "Eastern.tex",replace ///
cells(b(star fmt(%9.3f)) se(par)) ///
label stats(ll aic bic N, fmt(%9.1f) labels("Log likelihood" "AIC" "BIC" "Observations")) ///
title("Regression Results") ///
mtitle("OLS" "OLS" "SAR" "SEM" "SLX" "SDM") ///
star(* 0.10 ** 0.05 *** 0.01)





*Northeastern
*OLS
reg $ylist plngdppc2001 if location == 4
estimate store neiOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

reg $ylist $xlist if location == 4
estimate store neOLS
estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

*SAR
spregress $ylist $xlist if location == 4, ml dvarlag(WqueenS) force
eststo neSAR

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SEM
spregress $ylist $xlist if location == 4, ml errorlag(WqueenS) force
eststo neSEM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SLX
spregress $ylist $xlist if location == 4, ml ivarlag(WqueenS: $xlist) force
eststo neSLX

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*SDM
spregress $ylist $xlist if location == 4, ml dvarlag(WqueenS) ivarlag(WqueenS: $xlist) force
eststo neSDM

estat ic
mat s=r(S)
quietly estadd scalar AIC = s[1,5]

estat impact

*Comparison
esttab neOLS neSAR neSEM neSLX neSDM , label stats(AIC) mtitle("OLS" "SAR" "SEM" "SLX" "SDM") se b(%9.3f)

esttab neiOLS neOLS neSAR neSEM neSLX neSDM using "Northeastern.tex",replace ///
cells(b(star fmt(%9.3f)) se(par)) ///
label stats(ll aic bic N, fmt(%9.1f) labels("Log likelihood" "AIC" "BIC" "Observations")) ///
title("Regression Results") ///
mtitle("OLS" "OLS" "SAR" "SEM" "SLX" "SDM") ///
star(* 0.10 ** 0.05 *** 0.01)



*Compare the OLSs
esttab OLS cOLS eOLS wOLS neOLS , label stats(AIC) mtitle("OLS" "cOLS" "eOLS" "wOLS" "neOLS") se b(%9.3f)

esttab OLS cOLS eOLS wOLS neOLS using "AllOLS.tex",replace ///
cells(b(star fmt(%9.3f)) se(par)) ///
label stats(ll aic bic N, fmt(%9.1f) labels("Log likelihood" "AIC" "BIC" "Observations")) ///
title("Regression Results") ///
mtitle("OLS" "OLS" "OLS" "OLS" "OLS") ///
star(* 0.10 ** 0.05 *** 0.01)



*Compare the SEMs
esttab SEM cSEM eSEM wSEM neSEM , label stats(AIC) mtitle("SEM" "cSEM" "eSEM" "wSEM" "neSEM") se b(%9.3f)

esttab SEM cSEM eSEM wSEM neSEM using "AllSEM.tex",replace ///
cells(b(star fmt(%9.3f)) se(par)) ///
label stats(ll aic bic N, fmt(%9.1f) labels("Log likelihood" "AIC" "BIC" "Observations")) ///
title("Regression Results") ///
mtitle("SEM" "SEM" "SEM" "SEM" "SEM") ///
star(* 0.10 ** 0.05 *** 0.01)

*Compare the SDMs
esttab SDM cSDM eSDM wSDM neSDM , label stats(AIC) mtitle("SDM" "cSDM" "eSDM" "wSDM" "neSDM") se b(%9.3f)

esttab SDM cSDM eSDM wSDM neSDM using "AllSDM.tex",replace ///
cells(b(star fmt(%9.3f)) se(par)) ///
label stats(ll aic bic N, fmt(%9.1f) labels("Log likelihood" "AIC" "BIC" "Observations")) ///
title("Regression Results") ///
mtitle("SDM" "SDM" "SDM" "SDM" "SDM") ///
star(* 0.10 ** 0.05 *** 0.01)


*Scatterfit
scatterfit gdpgr plngdppc2001, ci vce(robust) regparameters(coef sig pval r2 nobs) parpos(2.7 10)

scatterfit gdpgr plngdppc2001, vce(robust) regparameters(coef sig pval r2 nobs) parpos(2.8 10) by(location)

