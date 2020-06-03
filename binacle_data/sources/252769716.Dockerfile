FROM cirit/tomcat:8-with-collectd-statsdjvmprofiler  
  
MAINTAINER Arkka Dhiratara <arkka.d@gmail.com>  
  
COPY target/* /usr/local/tomcat/webapps/

