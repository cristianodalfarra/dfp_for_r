reportquery_dfp_unit_like_right <- function(year,m_start,m_end,day_start,day_end,device_type,dfp_unit,dfp_unit_not,only_total){
  
  if (toString(device_type)=="d")
  {   device_type = "(30000,30002)"
  device_type_data = "desktop-tablet"
  device_type_file = "desktop-tablet"
  }
  else
  {   device_type = "(30001)" 
  device_type_data = "mobile"
  device_type_file = "mobile"
  }  
  
  #  where ((ad_exchange_gfp_inventory_unit_name in ('4507451 » LEAD_HP', '4507451 » SUPERLEAD_HP', '4507451 » SUPERLEAD_HP_middle', '4507451 » SQR_HP') and ad_exchange_platform_type_name in ('Desktop', 'Tablets')) and not (ad_exchange_dfp_ad_unit_top_level like 'TXTLINK_HP'))
  request_data <- list(reportJob=list(reportQuery=list(dimensions='AD_UNIT_NAME',
                                                        dimensions='DEVICE_CATEGORY_ID',
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
                                                       statement=list(query=paste0("WHERE AD_UNIT_NAME LIKE ","'%",dfp_unit,"%' ", " AND DEVICE_CATEGORY_ID IN",device_type," AND NOT AD_UNIT_NAME LIKE '%",dfp_unit_not,"%'"))    
                                                       #desktop=30000,tablet=30002,smartphone=30001
  )))
  
  
  
  #report_data_yesterday <- dfp_full_report_wrapper(request_data)
  dfp_runReportJob_result <- dfp_runReportJob(request_data)
  request_data <- list(reportJobId=dfp_runReportJob_result$id)
  dfp_getReportJobStatus_result <- dfp_getReportJobStatus(request_data)
  
  # a simple while loop can keep checking a long running request until ready
  counter <- 0
  while(dfp_getReportJobStatus_result!='COMPLETED' & counter < 100){
    print(counter*5)
    dfp_getReportJobStatus_result <- dfp_getReportJobStatus(request_data)
    Sys.sleep(5)
    counter <- counter + 1
  }
  
  # once the status is "COMPLETED" the data download URL can be retrieved
  request_data <- list(reportJobId=dfp_runReportJob_result$id, exportFormat='TSV')
  dfp_getReportDownloadURL_result <- dfp_getReportDownloadURL(request_data)
  
  
  report_dat <- dfp_report_url_to_dataframe(report_url=toString(dfp_getReportDownloadURL_result), 
                                            exportFormat='TSV')
  #head(report_dat)
  
  if (toString(only_total)=="yes")
  {   a=tail(report_dat,1)
  
  
  
  a[1]=paste(dfp_unit,device_type_data,toString(m_start),".",toString(year))
  a[2]="Total"  
  }
  else
  {   a=report_dat  }
  
  if (toString(only_total)=="yes")
  {   device_type_file = paste(device_type_file, "totale")
  }
  
  #library(xlsx)
  filename=paste(dfp_unit,device_type_file,toString(m_start),".",toString(year)) 
  write.csv(a, paste("C:/Users/Utente/Documents/R projects/RDFP/results/",filename,".csv"))
  
  
  return(a)
}

