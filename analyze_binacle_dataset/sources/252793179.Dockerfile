FROM openjdk:7  
MAINTAINER NotMe <dannielgutierrez90@gmail.com>  
  
#TomEE version  
ENV TOMEE_VERSION 7.0.1  
#Set Environment vars  
ENV CATALINA_HOME /opt/apache-tomee-plus-${TOMEE_VERSION}  
ENV PATH ${CATALINA_HOME}/bin:$PATH  
  
#Copy tomEE files  
COPY . /opt/  
  
#set workdir  
WORKDIR ${CATALINA_HOME}  
  
#expose ports  
EXPOSE 8005 8080 8009 8443 45564 4000  
CMD ${CATALINA_HOME}/bin/catalina.sh run  

