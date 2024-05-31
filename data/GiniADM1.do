clear all
import delimited "D:\CSMAR data\dataProcessing\GiniADM1.csv"
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
       text(0.28313 1990 "GDP", place(e)) ///:
	   text(0.79178 2010 "BM", place(e)) ///
       text(0.36721 1990 "CCNL", place(e)) ///
	   text(0.34724 1990 "HDMSP", place(e)) ///
       text(0.33069 2011 "HVIIRS", place(e)) ///
       text(0.57369 2011 "VIIRSV1", place(e)) ///
       text(0.26456 2011 "VIIRSV2", place(e)) ///
	   text(0.54326 1998 "VIIRS-like", place(e)) ///
	   text(0.58052 1990 "EGDP", place(e))