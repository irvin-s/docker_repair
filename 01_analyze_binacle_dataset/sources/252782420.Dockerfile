FROM debian:wheezy  
MAINTAINER Chris Hardekopf <cjh@ygdrasill.com>  
  
# Install influxdb package  
ADD http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb /tmp/  
RUN dpkg --install /tmp/influxdb_latest_amd64.deb && \  
rm /tmp/influxdb_latest_amd64.deb  
# The lastest influxdb is now available in /opt/influxdb/current/  
# Expose public ports (admin, http API, https API)  
EXPOSE 8083 8086 8084  
# Expose graphite API port  
EXPOSE 2003 2003/udp  
  
# raft and protobuf ports (clustering)  
# EXPOSE 8090 8099  
CMD [ "/opt/influxdb/influxd", "-config", "/opt/influxdb.conf" ]  

