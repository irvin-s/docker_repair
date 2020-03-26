FROM influxdb:0.13-alpine  
  
COPY influxdb.conf /etc/influxdb/influxdb.conf  
  
RUN apk add --no-cache --virtual curl  
COPY setup-influxdb.sh /setup-influxdb.sh  
RUN chmod +x /setup-influxdb.sh  
  
EXPOSE 8086  
CMD ["/setup-influxdb.sh"]  

