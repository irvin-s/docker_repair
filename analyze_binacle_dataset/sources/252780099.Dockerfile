# Pull base image  
From tomcat:8-jre8  
  
# Maintainer  
MAINTAINER "Aysegul Yalcinkaya <aysegulyalcinkayadel@gmail.com">  
  
# Copy to images tomcat path  
ADD Stack.war /usr/local/tomcat/webapps/

