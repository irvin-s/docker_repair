FROM cptactionhank/atlassian-bamboo:6.3.0  
  
MAINTAINER Darren Fang , <idarrenfang@gmail.com>  
  
WORKDIR /var/atlassian/bamboo  
  
USER root:root  
  
RUN apk add \--no-cache maven docker  
  
COPY "config/settings.xml" "/usr/share/java/maven-3/conf/settings.xml"  
  
USER daemon:daemon  

