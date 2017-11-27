reportquery_dfp_tag <- function(year,m_start,m_end,day_start,day_end,device_type,dfp_tag,only_total){
  
  if (toString(device_type)=="d")
  {   device_type = "(30000,30002)"  }
  else
  {   device_type = "(30001)"  }  
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
                                                       statement=list(query=paste("where DEVICE_CATEGORY_ID IN",device_type))  
                                                       #statement=list(query=paste0("WHERE AD_EXCHANGE_TAG_NAME = ","'",dfp_tag,"'", " AND DEVICE_CATEGORY_ID IN",device_type))  
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
  #head(report_dat)
  
  if (toString(only_total)=="yes")
  {   a=tail(report_dat,1)
  
  if (toString(device_type)=="d")
  {   device_type = "desktop-tablet"  }
  else
  {   device_type = "mobile"  }  
  
  
  a[1]=paste(dfp_tag,device_type,toString(m_start),".",toString(year))
  a[2]="Total"  
  }
  else
  {   a=report_dat  }
  
  a=subset(report_dat,  Tags==dfp_tag)
  
  
  #library(xlsx)
  filename=paste(dfp_tag,device_type,toString(m_start),".",toString(year)) 
  write.csv(a, paste("C:/Users/Utente/Documents/R projects/RDFP/results/",filename,".csv"))
  
  
  return(a)
}
