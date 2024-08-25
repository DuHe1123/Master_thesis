clear all

*Import data
cd "D:\Github Desktop\Master_thesis\data\county"
use "ADM3.dta", replace
*drop if citycode == 460300

*Drop years
drop if year <= 2000 | year >= 2022

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
replace reggdp_primary = . if reggdp_primary > reggdp

*Log transformation
gen lngdp = log(reggdp * 10000 + 1)
gen lnvl = log(vl3s * 10000 + 1)
gen lnpgdp = log(reggdp_primary * 10000 + 1)
gen lnnpp = log(modnpp * 10000 + 1)
gen lngdppc = log(perreggdp * 10000 + 1)
gen lnvlpc = log(vl3m * 10000 + 1)

gen lnnpgdp = log((reggdp_secondary + reggdp_tertiary)* 10000 + 1)
gen lnvl_urban = log(vl3s_urban * 10000 + 1)

*Predict Primary GDP
quietly xtreg lnpgdp lnnpp i.year i.citycode
predict plnpgdp, xb

*Predict Non-primary GDP
quietly xtreg lnnpgdp lnvl_urban i.year i.citycode
predict plnnpgdp, xb

*Generate total logged predicted GDP
gen plngdp = log(exp(plnpgdp) + exp(plnnpgdp))

*Predict GDPpc
quietly xtreg lngdppc lnvlpc i.year i.citycode
predict plngdppc, xb

*Generate new variables
replace modis_type10 = 0 if missing(modis_type10)
replace modis_type12 = 0 if missing(modis_type12)
replace modis_type13 = 0 if missing(modis_type13)
replace modis_type14 = 0 if missing(modis_type14)

gen nonagri_share = (exp(plngdp) - exp(plnpgdp)) * 100 / exp(plngdp)
replace nonagri_share = 0 if nonagri_share < 0
gen urbanland = log(modis_type13)
replace urbanland = 0 if missing(urbanland)
gen urbanland_share = modis_type13 * 100 / total_are
gen cropland = log(modis_type10 + modis_type12 + modis_type14)
replace cropland = 0 if missing(cropland)
gen cropland_share = (modis_type10 + modis_type12 + modis_type14) * 100 / total_are
gen popden = log(totalpop*100 / total_area)
gen urbanization = urban_pop * 100 / totalpop

*Save long panel
save "CleanData.dta", replace

export delimited using "D:\Github Desktop\Master_thesis\data\county\CleanData.csv", replace

*For visualization and other purposes

*Keep necessary variables
keep id year county countycode city citycode province provincecode reggdp reggdp_primary perreggdp plngdp plngdppc plnpgdp nonagri_share urbanland urbanland_share cropland cropland_share popden urbanization location

*Keep only the plngdppc variable and reshape, save into a csv
*keep id year plngdppc county countycode city citycode province provincecode location
*reshape wide plngdppc, i(id) j(year)
*export delimited using "D:\Github Desktop\Master_thesis\data\county\CleanData_wide_plngdppc_only.csv", replace

*Keep years
keep if year == 2001 | year == 2011 | year == 2021

*Reshape to wide
reshape wide reggdp reggdp_primary perreggdp plngdp plngdppc plnpgdp nonagri_share urbanland urbanland_share cropland cropland_share popden urbanization, i(id) j(year)

*Save wide panel (2001,2011,2021)
export delimited using "D:\Github Desktop\Master_thesis\data\county\CleanData_wide.csv", replace


*Extension: Does sectored GDPpc predicts better?
*gen lnnpgdppc = log(((reggdp_secondary + reggdp_tertiary) / popnum) * 10000 + 1)
*gen lnvlpc_urban = log(vl3m_urban * 10000 + 1)

*Predict non-primary gdppc
*quietly xtreg lnnpgdppc lnvlpc_urban i.year i.citycode
*predict plnnpgdppc, xb

*Predict primary gdppc
*We have no primary gdppc, so we used predicted total primary gdp to divide population
*gen plnpgdppc = log(exp(plnpgdp) / popnum)

*Merge
*gen plngdppc_by_sector = log(exp(plnpgdppc) + exp(plnnpgdppc))

*Test R2
*xtreg lngdppc plngdppc i.year, fe r
*xtreg lngdppc plngdppc_by_sector i.year, fe r