reportquery_dfp_tag <- function(year,m_start,m_end,day_start,day_end,device_type,dfp_tag,only_total){
  
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
    if (counter>10)
    {
      print("...long run")
      Sys.sleep(15) 
      filename=paste("warning",dfp_tag,device_type,toString(m_start),".",toString(year)) 
      write.table(dfp_tag, paste("C:/Users/Utente/Documents/R projects/RDFP/warnings/",filename,".txt"))
      
    }
    else
    {
      print(counter*5)
      Sys.sleep(5)
    }
    
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
  
  
  
  if (toString(only_total)=="yes")
  {   
    a=tail(report_dat,1)
    a[1]=paste(dfp_tag,device_type_data,toString(day_start),".",toString(day_end),toString(m_start),".",toString(year))
    #a[2]="Total"  
  }  
  }
  else
  {   a=report_dat  }
  
  
  a=subset(report_dat,  Tags==dfp_tag)
  
  
  #library(xlsx)
  library(tibble)
  filename=paste(dfp_tag,device_type_file,toString(m_start),".",toString(year)) 
  a[1]=paste(dfp_tag,device_type_data,toString(day_start),"-",toString(day_end),toString(m_start),"/",toString(year))
  write.csv(a, paste("C:/Users/Utente/Documents/R projects/RDFP/results/",filename,".csv"))
  assign("X", a, .GlobalEnv)
  assign("A", a, .GlobalEnv)
  if("Ad.unit.ID" %in% colnames(A)==FALSE) 
    {
    print("test")
    A=add_column(A, "Ad.unit.ID" = "", .after = 1)
    
    }
  
  colnames(A)[1] <- "Ad.unit"
  A[2]="Total"
  #A[1]=paste(dfp_tag,device_type_data,toString(m_start),".",toString(year))
  print(A)
  b=rbind.data.frame(A,TOT)
  assign("TOT", b, .GlobalEnv)
  
  return(a)
}
