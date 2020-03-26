FROM ubuntu:16.04
COPY influxdb-router /
ENTRYPOINT ["/influxdb-router"]
