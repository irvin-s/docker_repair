FROM tomcat:7-jre7  
COPY ./session-replication.war /usr/local/tomcat/webapps/  
ADD run.sh /run.sh  
RUN chmod +x /run.sh  
CMD /run.sh  

