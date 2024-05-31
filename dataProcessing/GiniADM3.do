clear all
import delimited "D:\CSMAR data\dataProcessing\GiniADM3.csv"
twoway (line gini_gdp year) ///
       (line gini_bm year) ///
       (line gini_ccnl year) ///
       (line gini_hdmsp year) ///
       (line gini_hviirs year) ///
       (line gini_viirsv1 year) ///
	   (line gini_viirsv2 year) ///
       (line gini_viirsl year) ///
       (line gini_egdp year) ///
       , ///
       text(0.40933 1998 "GDP", place(e)) ///:
	   text(0.90152 2011 "BM", place(e)) ///
       text(0.57865 1998 "CCNL", place(e)) ///
	   text(0.5 2003 "HDMSP", place(e)) ///
       text(0.55185 2011 "HVIIRS", place(e)) ///
       text(0.55683 2014 "VIIRSV1", place(e)) ///
	   text(0.58289 2011 "VIIRSV2", place(e)) ///
	   text(0.78 2002 "VIIRS-like", place(e)) ///
	   text(0.80644 1998 "EGDP", place(e))