clear all
input str6 NTL adm1 adm2 adm3
"CCNL" 0.731 0.678 0.587
"HDMSP" 0.685 0.648 0.582
"EGDP" 0.366 0.423 0.378
"VIIRSL" 0.723 0.649 0.540
end

graph bar adm1 adm2 adm3, over(NTL) ///
    title("R-square for Two-way Fixed Effects At Period 1") ///
    yscale(range(0 0.9)) ///
	legend(label(1 "ADM1") label(2 "ADM2") label(3 "ADM3"))

clear all
input str6 NTL adm1 adm2 adm3
"VIIRSV1" 0.070 0.038 0.028
"HVIIRS" 0.077 0.057 0.081
"VIIRSV2" 0.327 0.623 0.529
"BM" 0.329 0.033 0.006
"EGDP" 0.002 0.243 0.291
"VIIRSL" 0.441 0.699 0.546
end

graph bar adm1 adm2 adm3, over(NTL) ///
    title("R-square for Two-way Fixed Effects At Period 2") ///
    yscale(range(0 0.9)) ///
	legend(label(1 "ADM1") label(2 "ADM2") label(3 "ADM3"))
	


