FROM maven:3.3-jdk-8  
RUN apt-get update && \  
apt-get install -yq --no-install-recommends wget pwgen ca-certificates && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
ENV TOMCAT_MAJOR_VERSION 8  
ENV TOMCAT_MINOR_VERSION 8.0.11  
ENV CATALINA_HOME /tomcat  

