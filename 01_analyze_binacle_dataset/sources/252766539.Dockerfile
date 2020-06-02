FROM composer  
  
RUN composer global require bramus/mixed-content-scan:~2.8  
  
ENTRYPOINT ["mixed-content-scan"]  

