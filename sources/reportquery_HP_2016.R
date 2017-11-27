reportquery_HP_2016 <- function(year,m_start,m_end,day_start,day_end,device_type){
  
  if (toString(device_type)=="d")
  {   device_type = "(30000,30002)"
  device_type_data = "desktop-tablet"
  device_type_file = "desktop-tablet"
  }
  if (toString(device_type)=="m")
  {   device_type = "(30001)" 
  device_type_data = "mobile"
  device_type_file = "mobile"
  }
  
  if (toString(device_type)=="all")
  {   device_type = "(30000,30002,30001)"
  device_type_data = "desktop-tablet-mobile"
  device_type_file = "desktop-tablet-mobile"
  }
      
  
  
  #where ad_exchange_tag_name in ('superlead dettaglio', 'Box dettaglio', 'Half Page testuali referral - no clienti', 'Widget adx')
  request_data <- list(reportJob=list(reportQuery=list(dimensions='AD_EXCHANGE_TAG_NAME',
                                                       adUnitView='FLAT',
                                                       columns='AD_EXCHANGE_REQUESTS',
                                                       columns="AD_EXCHANGE_MATCHED_QUERIES",
                                                       columns="AD_EXCHANGE_COVERAGE",
                                                       columns="AD_EXCHANGE_CLICKS",
                                                       columns="AD_EXCHANGE_MATCHED_QUERIES_CTR",
                                                       columns="AD_EXCHANGE_CPC_REVENUE",
                                                       columns="AD_EXCHANGE_REQUEST_ECPM",
                                                       columns="AD_EXCHANGE_ESTIMATED_REVENUE",
                                                       startDate=list(year=toString(year), month=toString(m_start), day=toString(day_start) ),
                                                       endDate=list(year=toString(year), month=toString(m_end), day=toString(day_end)),
                                                       dateRangeType='CUSTOM_DATE',
                                                       statement=list(query=paste("WHERE DEVICE_CATEGORY_ID IN",device_type))  
                                                       #statement=list(query=paste("WHERE DEVICE_CATEGORY_ID IN",device_type))  
                                                       #desktop=30000,tablet=30002,smartphone=30001
  )))
  
  
  
  #report_data_yesterday <- dfp_full_report_wrapper(request_data)
  dfp_runReportJob_result <- dfp_runReportJob(request_data)
  request_data <- list(reportJobId=dfp_runReportJob_result$id)
  dfp_getReportJobStatus_result <- dfp_getReportJobStatus(request_data)
  
  # a simple while loop can keep checking a long running request until ready
  counter <- 0
  while(dfp_getReportJobStatus_result!='COMPLETED' & counter < 100){
    dfp_getReportJobStatus_result <- dfp_getReportJobStatus(request_data)
    Sys.sleep(3)
    counter <- counter + 1
  }
  
  # once the status is "COMPLETED" the data download URL can be retrieved
  request_data <- list(reportJobId=dfp_runReportJob_result$id, exportFormat='TSV')
  dfp_getReportDownloadURL_result <- dfp_getReportDownloadURL(request_data)
  
  
  report_dat <- dfp_report_url_to_dataframe(report_url=toString(dfp_getReportDownloadURL_result), 
                                            exportFormat='TSV')
  
  a=subset(report_dat,  Tags=="Mobile HP 320x100"|
                        Tags=="TEST - box redesign HP" | 
                        Tags=="TEST - superleaderboard redesign - top HP"| 
                        Tags== "TEST - superleaderboard redesign - bottom HP")
  print (device_type)
  
  
  
  
  filename=paste("HP",device_type_file,toString(m_start),".",toString(year)) 
  write.csv(a, paste("C:/Users/Utente/Documents/R projects/RDFP/",filename,".csv"))
  
  print (device_type)
  return (a)
  
}