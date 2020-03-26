#  
# dockerfile basado en tomcat  
#  
FROM tomcat:7-jre7  
  
RUN apt-get update -y &&\  
apt-get install vim -y &&\  
apt-get install nano  
  
EXPOSE 8080  

