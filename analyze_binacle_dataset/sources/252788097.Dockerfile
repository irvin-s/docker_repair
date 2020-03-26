FROM crcsi/geoserver:2.12.3  
MAINTAINER Alex Leith <aleith@crcsi.com.au>  
  
# Python is not installed out of the box.  
RUN apt-get update && apt-get install -y python  
  
# Default value for GeoServer home (can be overridden at runtime).  
ENV GEOSERVER_HOME=/opt/geoserver  
  
ADD . $GEOSERVER_HOME/docker/  
  
RUN mv $GEOSERVER_HOME/docker/data/server.xml /usr/local/tomcat/conf/  
  
CMD $GEOSERVER_HOME/docker/run.sh  

