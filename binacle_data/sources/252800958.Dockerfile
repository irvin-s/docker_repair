FROM dpatriot/docker-awscli-java8  
MAINTAINER Shago Vyacheslav <v.shago@corpwebgames.com>  
  
ADD run.sh /opt/  
RUN chmod +x /opt/run.sh  
  
ADD import-rds-ca.sh /opt/  
RUN chmod +x /opt/import-rds-ca.sh && /opt/import-rds-ca.sh  
  
# Define working directory.  
WORKDIR /opt  
  
ENTRYPOINT ["./run.sh"]  
  
CMD [""]  

