FROM armel/busybox

COPY influxd /usr/bin/
COPY influxdb.toml /etc/

ENTRYPOINT ["influxd", "--config", "/etc/influxdb.toml"]
