FROM beauzeaux/spark-base  
MAINTAINER Nick Beaulieu, beauzeaux@outlook.com  
  
ADD ./setup/startup.sh /opt/setup/  
RUN chmod +x /opt/setup/startup.sh  
  
EXPOSE 7077 8080  
ENTRYPOINT /opt/setup/startup.sh  

