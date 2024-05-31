clear all
import delimited "D:\CSMAR data\dataProcessing\GiniADM2.csv"
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
       text(0.48 1990 "GDP", place(e)) ///:
	   text(0.85619 2010 "BM", place(e)) ///
       text(0.54496 1990 "CCNL", place(e)) ///
	   text(0.52 1990 "HDMSP", place(e)) ///
       text(0.41906 2011 "HVIIRS", place(e)) ///
       text(0.70271 2011 "VIIRSV1", place(e)) ///
	   text(0.46493 2011 "VIIRSV2", place(e)) ///
	   text(0.79186 1998 "VIIRS-like", place(e)) ///
	   text(0.58753 1990 "EGDP", place(e))