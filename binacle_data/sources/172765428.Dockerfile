FROM busybox

ADD influxdb /usr/bin/influxdb
ADD run_influxdb /usr/bin/run_influxdb
ADD config.toml /etc/influxdb/config.toml

EXPOSE 8083 8086 8090 8099

CMD ["/usr/bin/run_influxdb"]
