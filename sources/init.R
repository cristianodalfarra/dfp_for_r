##################################### https://stevenmortimer.com/project/rdfp/#how-to-get-started
##################https://stackoverflow.com/questions/46476295/unable-to-pull-saved-query-from-google-dfp-using-r-studio
###https://cran.r-project.org/web/packages/googlesheets/vignettes/basic-usage.html#register-a-sheet

#======## TO READ oAuth https://support.rstudio.com/hc/en-us/articles/217952868-Generating-OAuth-tokens-from-a-server
#***** ADX DFP migration https://developers.google.com/doubleclick-publishers/docs/adx_reporting_migration
# ############## dashboard: https://datastudio.google.com/reporting/0B8_ub-Gf21e-cG1uQV9GQnFzdzQ/page/M7xI

#devtools::install_github("ReportMort/rdfp")

#https://developers.google.com/doubleclick-publishers/docs/pqlreference
#https://developers.google.com/doubleclick-publishers/docs/reference/v201702/ReportService.ReportQuery

### timezones: https://groups.google.com/forum/#!topic/google-doubleclick-for-publishers-api/Knv3qiNCRJg


library(rdfp)
library(magrittr)
library(formattable)
library(httr)
# options(stringsAsFactors = FALSE)
# options(rdfp.network_code = "4507451")
# options(rdfp.application_name = "MyAppDFP")
# options(rdfp.client_id = "430054733100-o7vbb1eujetulrh6nk1gipfpmu8v6dpo.apps.googleusercontent.com")
# options(rdfp.client_secret = "fyqqSUzmlCFcpA-pZxlT0wOB")


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

# non necessario richiamare il file con il token
dfp_auth(token = "DFP_token.rds")



##############################################
#https://github.com/ReportMort/rdfp/issues/4
##############################################

# auth_google_services <- function(services = c('sheets', 
#                                               'sites', 
#                                               'drive', 
#                                               'analytics', 
#                                               'dfp'),
#                                  key = key, 
#                                  secret = secret)
# {
#   
#   which_services <- match.arg(services, several.ok = TRUE)
#   
#   supported_scopes <- c(sheets = "https://spreadsheets.google.com/feeds", 
#                         sites = "https://sites.google.com/feeds/", 
#                         drive = "https://www.googleapis.com/auth/drive", 
#                         analytics = "https://www.googleapis.com/auth/analytics", 
#                         dfp = "https://www.googleapis.com/auth/dfp")
#   
#   myapp <- oauth_app("google", 
#                      key = key, 
#                      secret = secret)
#   
#   google_endpoint <- oauth_endpoints("google")
#   
#   new_token <- oauth2.0_token(google_endpoint,myapp,scope = unname(supported_scopes[which_services]))
#   
#   assign("token", new_token, envir=rdfp:::.state)
#   
#   # Some packages, like RGoogleAnalytics requires you to 
#   # pass the token directly, so we'll return it invisibly
#   invisible(new_token)
# }
# 
# token <- auth_google_services(services=c('drive', 'sheets', 'dfp'), 
#                               key='430054733100-o7vbb1eujetulrh6nk1gipfpmu8v6dpo.apps.googleusercontent.com', 
#                               secret='fyqqSUzmlCFcpA-pZxlT0wOB')
# ##############################################################################################
# 
# 
# dfp_auth(token)
