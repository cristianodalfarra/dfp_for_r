
m1 = 10
m2 = 10
d1 = 1
d2 = 31

source('~/R projects/RDFP/sources/init.R')


source("~/R projects/RDFP/sources/reportquery_dfp_unit.r")
source('~/R projects/RDFP/sources/reportquery_dfp_unit_like.R', encoding = 'UTF-8')
source('~/R projects/RDFP/sources/reportquery_dfp_unit_like_right.R', encoding = 'UTF-8')  #like solo a destra

source('~/R projects/RDFP/sources/reportquery_HP_2016.R')

source('~/R projects/RDFP/sources/reportquery_dfp_tag.R')




#reportquery(year=2017,m_start=m1,m_end=m2,day_start=23,day_end=d2,device_type="m",dfp_unit="SUPERLEAD_CAT")
#reportquery_dfp_unit(year=2017,m_start=m1,m_end=m2,day_start=23,day_end=d2,device_type="d",dfp_unit="HP",only_total="yes")
#reportquery_HP_2016(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d")

#reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="Mobile HP 320x100",only_total="yes")

##################################################  <HP>  ##### d=desktop+tablet, m=mobile; all=all devices
TOT=NULL

reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="TEST - superleaderboard redesign - top HP",only_total="yes")
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="TEST - superleaderboard redesign - bottom HP",only_total="yes")
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="TEST - box redesign HP",only_total="yes")
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_tag="Mobile HP 320x100",only_total="yes")

reportquery_dfp_unit(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="LEAD_HP",only_total="yes")
reportquery_dfp_unit(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="SQR_HP",only_total="yes")
reportquery_dfp_unit(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="SUPERLEAD_HP",only_total="yes")


reportquery_dfp_unit(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="LEAD_HP",only_total="yes")
reportquery_dfp_unit(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="SQR_HP",only_total="yes")
reportquery_dfp_unit(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="SUPERLEAD_HP",only_total="yes")
reportquery_dfp_unit(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="SUPERLEAD_HP_middle",only_total="yes")

reportquery_dfp_unit(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="LEAD_HP",only_total="yes")
reportquery_dfp_unit(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="SQR_HP",only_total="yes")
reportquery_dfp_unit(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="SUPERLEAD_HP",only_total="yes")
reportquery_dfp_unit(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="SUPERLEAD_HP_middle",only_total="yes")

write.xlsx(TOT, paste("C:/Users/Utente/Documents/R projects/RDFP/report/","HP_ALL.xlsx"))


########################################################## </HP>    #####


##################################################  <LISTING>  ##### d=desktop+tablet, m=mobile; all=all devices
TOT=NULL

#Report ADX - LISTING - MOBILE - superlead_cat + lead_cat (trasferito da AdX)
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_tag="Mobile Elenco - test 2",only_total="yes")
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_tag="MOBILE TOP - elenco",only_total="yes")

#listing 2016
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="Ledarboard Adx",only_total="yes")
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="Skyscraper Adx",only_total="yes")
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="Skyscraper Adx (no floor)",only_total="yes")
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="superlead elenco bottom",only_total="yes")  ###lento

#Report ADX - LISTING - desktop tablet - SKY_CAT 2016
reportquery_dfp_unit_like(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%SKY_CAT%",only_total="yes")

#Report ADX - LISTING - desktop tablet - SKY_CAT 2017
reportquery_dfp_unit_like(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%SKY_CAT%",only_total="yes")

#Report ADX - LISTING - mobile - SUPERLEAD_CAT 2016
reportquery_dfp_unit_like(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="%SUPERLEAD_CAT%",only_total="yes")

#Report ADX - LISTING - mobile - SUPERLEAD_CAT 2017
reportquery_dfp_unit_like(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="%SUPERLEAD_CAT%",only_total="yes")

#Report ADX - LISTING - desktop tablet - SUPERLEAD_CAT 2016
reportquery_dfp_unit_like(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%SUPERLEAD_CAT%",only_total="yes")

#Report ADX - LISTING - desktop tablet - SUPERLEAD_CAT 2017
reportquery_dfp_unit_like(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%SUPERLEAD_CAT%",only_total="yes")

###################################################### LEAD_CAT
#Report ADX - LISTING - mobile - LEAD_CAT 2016
reportquery_dfp_unit_like_right(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="LEAD_CAT",dfp_unit_not="SUPERLEAD",only_total="yes")

#Report ADX - LISTING - mobile - LEAD_CAT 2017
reportquery_dfp_unit_like_right(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="LEAD_CAT",dfp_unit_not="SUPERLEAD",only_total="yes")

#Report ADX - LISTING - desktop tablet- LEAD_CAT 2016  (da omettere)
reportquery_dfp_unit_like_right(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="LEAD_CAT",dfp_unit_not="SUPERLEAD",only_total="yes")

#Report ADX - LISTING - desktop tablet - LEAD_CAT 2017
reportquery_dfp_unit_like_right(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="LEAD_CAT",dfp_unit_not="SUPERLEAD",only_total="yes")

write.xlsx(TOT, paste("C:/Users/Utente/Documents/R projects/RDFP/report/","LISTING_ALL.xlsx"))



##################################################  <DETTAGLIO>  ##### d=desktop+tablet, m=mobile; all=all devices
TOT=NULL
# 
# sqr det 2016
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_tag="Mobile dettaglio 300x250",only_total="yes")

# lead det 2016
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_tag="MOBILE TOP - dettaglio",only_total="yes")
# 
# 
# sqr_det
# half_page
# Lead_det
# w_box
# 
# Box dettaglio 2016 desktop
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="Box dettaglio",only_total="yes")

# Half Page testuali referral - no clienti 2016     desktop
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="Half Page testuali referral - no clienti",only_total="yes")

# superlead dettaglio 2016    desktop
reportquery_dfp_tag(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_tag="superlead dettaglio",only_total="yes")
# 


# Report ADX - DETTAGLIO - desktop tablet- HALF_PAGE 2016
reportquery_dfp_unit_like(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%HALF_PAGE%",only_total="yes")
# 
# report ADX - DETTAGLIO - desktop tablet - HALF_PAGE 2017
reportquery_dfp_unit_like(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%HALF_PAGE%",only_total="yes")
# 
# Report ADX - DETTAGLIO - mobile - SQR_DET 2016
reportquery_dfp_unit_like(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="%SQR_DET%",only_total="yes")

# Report ADX - DETTAGLIO - mobile - SQR_DET 2017
reportquery_dfp_unit_like(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="%SQR_DET%",only_total="yes")
# 
# Report ADX - DETTAGLIO - desktop tablet - SQR_DET 2016
reportquery_dfp_unit_like(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%SQR_DET%",only_total="yes")

# Report ADX - DETTAGLIO - desktop tablet - SQR_DET 2017
reportquery_dfp_unit_like(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%SQR_DET%",only_total="yes")
# 
# Report ADX - DETTAGLIO - mobile - LEAD_DET 2016
reportquery_dfp_unit_like_right(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="LEAD_DET",dfp_unit_not="SUPERLEAD",only_total="yes")

# Report ADX - DETTAGLIO - mobile - LEAD_DET 2017
reportquery_dfp_unit_like_right(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="m",dfp_unit="LEAD_DET",dfp_unit_not="SUPERLEAD",only_total="yes")
# 

# Report ADX - DETTAGLIO - desktop tablet - LEAD_DET 2016
reportquery_dfp_unit_like_right(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="LEAD_DET",dfp_unit_not="SUPERLEAD",only_total="yes")
# 
# Report ADX - DETTAGLIO - desktop tablet - LEAD_DET 2017
reportquery_dfp_unit_like_right(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="LEAD_DET",dfp_unit_not="SUPERLEAD",only_total="yes")
# 
# 
######################################################  WBOX
# Report ADX - DETTAGLIO -  desktop tablet - WBOX 2016
reportquery_dfp_unit_like(year=2016,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%WBOX%",only_total="yes")# 


# Report ADX - DETTAGLIO -  desktop tablet - WBOX 2017
reportquery_dfp_unit_like(year=2017,m_start=m1,m_end=m2,day_start=d1,day_end=d2,device_type="d",dfp_unit="%WBOX%",only_total="yes")# 

write.xlsx(TOT, paste("C:/Users/Utente/Documents/R projects/RDFP/report/","DETTAGLIO_ALL.xlsx"))