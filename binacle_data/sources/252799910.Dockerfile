# Influxdb  
FROM digitalwonderland/base:latest  
  
ADD src/ /  
  
RUN chmod +x /usr/local/sbin/start.sh  
  
RUN rpm -Uvh http://s3.amazonaws.com/influxdb/influxdb-latest-1.x86_64.rpm  
  
RUN mkdir -p /var/{lib/influxdb,log/influxdb,run/influxdb} \  
&& chown -R influxdb:influxdb /var/{lib/influxdb,log/influxdb,run/influxdb}  
  
EXPOSE 2003 2003/udp 8083 8086 8090 8099  
VOLUME ["/etc/influxdb", "/var/lib/influxdb", "/var/log/influxdb"]  
  
ENTRYPOINT ["/usr/local/sbin/start.sh"]  

