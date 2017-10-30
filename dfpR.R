##################################### https://stevenmortimer.com/project/rdfp/#how-to-get-started
##################https://stackoverflow.com/questions/46476295/unable-to-pull-saved-query-from-google-dfp-using-r-studio
###https://cran.r-project.org/web/packages/googlesheets/vignettes/basic-usage.html#register-a-sheet

#======## TO READ oAuth https://support.rstudio.com/hc/en-us/articles/217952868-Generating-OAuth-tokens-from-a-server
#***** ADX DFP migration https://developers.google.com/doubleclick-publishers/docs/adx_reporting_migration
# ############## dashboard: https://datastudio.google.com/reporting/0B8_ub-Gf21e-cG1uQV9GQnFzdzQ/page/M7xI

#devtools::install_github("ReportMort/rdfp")

library(rdfp)
library(magrittr)
library(formattable)
# options(stringsAsFactors = FALSE)
# options(rdfp.network_code = "4507451")
# options(rdfp.application_name = "MyAppDFP")
# options(rdfp.client_id = "430054733100-o7vbb1eujetulrh6nk1gipfpmu8v6dpo.apps.googleusercontent.com")
# options(rdfp.client_secret = "fyqqSUzmlCFcpA-pZxlT0wOB")
# 
# # 
# # ######################################################################
# # how to create oauth token for DFP and GDrive
# 
# file.remove('.httr-oauth') # Remove current token
# library(httr)
# 
# oauth2.0_token(
#   endpoint = oauth_endpoints("google"),
#   app = oauth_app(
#     "google",
#     key = getOption("rdfp.client_id"),
#     secret = getOption("rdfp.client_secret")
#   ),
#   scope = c(
#     "https://spreadsheets.google.com/feeds",
#     "https://www.googleapis.com/auth/dfp",
#     "https://www.googleapis.com/auth/drive"),
#   use_oob = FALSE,
#   cache = TRUE
# )
# token <- dfp_auth(cache = TRUE)
# saveRDS(token, file = "DFP_token.rds")
#########################################################################



options(rdfp.network_code = "4507451",
        rdfp.application_name = "MyAppDFP",
        rdfp.client_id = "430054733100-o7vbb1eujetulrh6nk1gipfpmu8v6dpo.apps.googleusercontent.com",
        rdfp.client_secret = "fyqqSUzmlCFcpA-pZxlT0wOB",
        rdfp.httr_oauth_cache = TRUE)

dfp_auth(token = "DFP_token.rds")



today <- Sys.Date()

yesterday_day = format(as.Date(today-1,format="%Y-%m-%d"), "%d")
yesterday_month = format(as.Date(today-1,format="%Y-%m-%d"), "%m")
yesterday_year = format(as.Date(today-1,format="%Y-%m-%d"), "%y")



ieri = paste("20",yesterday_year,yesterday_month,yesterday_day,sep="")
ieri_check=today-1



request_data <- list(reportJob=list(reportQuery=list(dimensions='AD_EXCHANGE_TAG_NAME',
                                                     dimensions='DATE',
                                                     adUnitView='TOP LEVEL',
                                                     columns='AD_EXCHANGE_REQUESTS',
                                                     columns="AD_EXCHANGE_MATCHED_QUERIES",
                                                     columns="AD_EXCHANGE_COVERAGE",
                                                     columns="AD_EXCHANGE_CLICKS",
                                                     columns="AD_EXCHANGE_MATCHED_QUERIES_CTR",
                                                     columns="AD_EXCHANGE_CPC_REVENUE",
                                                     columns="AD_EXCHANGE_REQUEST_ECPM",
                                                     columns="AD_EXCHANGE_ESTIMATED_REVENUE",
                                                     startDate=list(year=2017, month=yesterday_month, day=yesterday_day),
                                                     endDate=list(year=2017, month=yesterday_month, day=yesterday_day),
                                                     dateRangeType='CUSTOM_DATE')))

report_data_yesterday <- dfp_full_report_wrapper(request_data)
report_data_yesterday[10]= report_data_yesterday[10]/10^6

#last_week
lastweek_day = format(as.Date(today-8,format="%Y-%m-%d"), "%d")
lastweek_month = format(as.Date(today-8,format="%Y-%m-%d"), "%m")

sett_scorsa= paste("2017",lastweek_month,lastweek_day,sep="")
lastweek_check = today-8

# creazioen df con le date ottenute dai report DFP
dfp_yesterday = report_data_yesterday[which.max(report_data_yesterday$Dimension.DATE), ][2]
dfp_lastweek = report_data_lastweek[which.max(report_data_lastweek$Dimension.DATE), ][2]
date_from_dfp = NULL
date_from_dfp = data.frame(dfp_yesterday,dfp_lastweek,ieri_check,lastweek_check)

date_1=as.Date(paste(date_from_dfp$Dimension.DATE), "%Y-%m-%d")
date_2=as.Date(paste(date_from_dfp$Dimension.DATE.1), "%Y-%m-%d") 

if (date_1==date_from_dfp[3] && date_2==date_from_dfp[4] ) {
  check_date="report aggiornato"
} else {
  check_date="report da aggiornare"
}

date_from_dfp = data.frame(date_from_dfp,check_date)



ieri = paste("20",yesterday_year,yesterday_month,yesterday_day,sep="")
ieri_check=today-1



request_data <- list(reportJob=list(reportQuery=list(dimensions='AD_EXCHANGE_TAG_NAME',
                                                     dimensions='DATE',
                                                     adUnitView='TOP LEVEL',
                                                     columns='AD_EXCHANGE_REQUESTS',
                                                     columns="AD_EXCHANGE_MATCHED_QUERIES",
                                                     columns="AD_EXCHANGE_COVERAGE",
                                                     columns="AD_EXCHANGE_CLICKS",
                                                     columns="AD_EXCHANGE_MATCHED_QUERIES_CTR",
                                                     columns="AD_EXCHANGE_CPC_REVENUE",
                                                     columns="AD_EXCHANGE_REQUEST_ECPM",
                                                     columns="AD_EXCHANGE_ESTIMATED_REVENUE",
                                                     startDate=list(year=2017, month=lastweek_month, day=lastweek_day),
                                                     endDate=list(year=2017, month=lastweek_month, day=lastweek_day),
                                                     dateRangeType='CUSTOM_DATE')))

report_data_lastweek <- dfp_full_report_wrapper(request_data)
report_data_lastweek[10]= report_data_lastweek[10]/10^6

#last_2_weeks
last_2_weeks_day = format(as.Date(today-15,format="%Y-%m-%d"), "%d")
last_2_weeks_month = format(as.Date(today-15,format="%Y-%m-%d"), "%m")


request_data_last_2_weeks <- list(reportJob=list(reportQuery=list(dimensions='AD_EXCHANGE_TAG_NAME',
                                                                  dimensions='DATE',
                                                     adUnitView='TOP LEVEL',
                                                     
                                                     columns='AD_EXCHANGE_REQUESTS',
                                                     columns="AD_EXCHANGE_MATCHED_QUERIES",
                                                     columns="AD_EXCHANGE_COVERAGE",
                                                     columns="AD_EXCHANGE_CLICKS",
                                                     columns="AD_EXCHANGE_MATCHED_QUERIES_CTR",
                                                     columns="AD_EXCHANGE_CPC_REVENUE",
                                                     columns="AD_EXCHANGE_REQUEST_ECPM",
                                                     columns="AD_EXCHANGE_ESTIMATED_REVENUE",
                                                     startDate=list(year=2017, month=last_2_weeks_month, day=last_2_weeks_day),
                                                     endDate=list(year=2017, month=last_2_weeks_month, day=last_2_weeks_day),
                                                     dateRangeType='CUSTOM_DATE')))

report_data_last_2_weeks <- dfp_full_report_wrapper(request_data_last_2_weeks)
report_data_last_2_weeks[10]= report_data_last_2_weeks[10]/10^6


#merge ieri e settimana scora
a= merge(report_data_yesterday,report_data_lastweek, by="Dimension.AD_EXCHANGE_TAG_NAME")


# colonna variazione
a[20]=a[10]/a[19]-1

# valori sopra e sotto 15%
valori_15=subset(a, (a[20] >0.15 | a[20] < -0.15))
valori_15[20]= format(round(valori_15[20], 2), nsmall = 2)
casi = valori_15[,c(1,20)]
casi_all = a[,c(1,20)]

#merge ieri e 2 settimana fa
b= merge(report_data_yesterday,report_data_last_2_weeks, by="Dimension.AD_EXCHANGE_TAG_NAME")


# colonna variazione

b[20]=b[10]/b[19]-1

# valori sopra e sotto 15%
valori_15=subset(a, (b[20] >0.15 | b[20] < -0.15))
valori_15[20]= format(round(valori_15[20], 2), nsmall = 2)
casi = valori_15[,c(1,20)]
casi_all = b[,c(1,20)]


#calcolo revenue 
s_somma_scorsa_sett=sum(report_data_lastweek[10])
somma_scorsa_sett = format(round(s_somma_scorsa_sett, 2), nsmall = 2)

s_somma_scorsa_2_sett=sum(report_data_last_2_weeks[10])
somma_scorsa_2_sett = format(round(s_somma_scorsa_2_sett, 2), nsmall = 2)

s_somma_ieri=sum(report_data_yesterday[10])
somma_ieri = format(round(s_somma_ieri, 2), nsmall = 2)

#calcolo variazione 
s_variazione = (s_somma_ieri/s_somma_scorsa_sett -1)
s_variazione_2_sett = (s_somma_ieri/s_somma_scorsa_2_sett -1)

variazione = percent(s_variazione)
variazione_2_sett = percent(s_variazione_2_sett)

#creazione df per export in google spreadsheet
somme.data <- data.frame(somma_scorsa_sett, somma_ieri, variazione)
somme.data_2_sett <- data.frame(somma_scorsa_2_sett, somma_ieri, variazione_2_sett)

#scrittura gsheet
library(googlesheets)

# token <- gs_auth(cache = TRUE)
# gd_token()
# saveRDS(token, file = "googlesheets_token.rds")

#gs_auth(token = "googlesheets_token.rds")
suppressMessages(gs_auth(token = "googlesheets_token.rds", verbose = FALSE))


gap = gs_ls("ADsense daily")

#registrazione file
gap <- gs_title("ADsense daily")

# aggiunta celle nel tab 'dfp_casi'
gap <- gap %>%
  gs_edit_cells(ws = "dfp_casi", input = casi_all, trim = TRUE)

# aggiunta celle nel tab 'dfp_somme'
gap <- gap %>%
  gs_edit_cells(ws = "dfp_somme", input = somme.data, trim = TRUE)

gap <- gap %>%
  gs_edit_cells(ws = "date_dfp", input = date_from_dfp, trim = TRUE)


# 
# this_result <- dfp_getSavedQueriesByStatement(list(filterStatement=list(query="WHERE id = 10034904587")), as_df=F)
# this_report_query <- this_result$rval$results$reportQuery
# 
# report_request_data2 <- list(reportJob=list(reportQuery = this_report_query))
# delivery_dat2 <- dfp_full_report_wrapper(report_request_data2)
