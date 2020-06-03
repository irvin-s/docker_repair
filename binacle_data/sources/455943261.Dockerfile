FROM influxdb
ADD influxdb.conf /etc/influxdb/ 
EXPOSE 8086
VOLUME /var/lib/influxdb
CMD ["influxd"]
