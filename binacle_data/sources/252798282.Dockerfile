FROM tomcat:7-jre8  
  
# Environment variables are defaults and should be overwritten on docker-run!  
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64  
ENV TOMCAT_HOME /usr/local/tomcat  
ENV BCS /opt/projektron/bcs  
ENV PROJEKTRON_VERSION projektron-bcs-7.26.40  
# Install netstat  
RUN apt-get update && apt-get install -y \  
net-tools \  
postgresql  
  
# Copy scripts to root folder  
COPY tools/ /var/  
  
# Set wirkdir to BCS directory  
WORKDIR $BCS  
  
# Prepare script to download bcs-files to BCS directory  
RUN chmod +x /var/scripts/*  

