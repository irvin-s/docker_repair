# influxdb

FROM ubuntu

RUN mkdir -p /opt/influxdb/shared/data

ADD http://s3.amazonaws.com/influxdb/influxdb_0.8.0-rc.3_amd64.deb /influxdb_latest_amd64.deb
RUN dpkg -i /influxdb_latest_amd64.deb
RUN rm -rf /opt/influxdb/shared/data

ADD config.toml /opt/influxdb/shared/config.toml

EXPOSE 8083 8086 8084 8090 8099

ENTRYPOINT ["/usr/bin/influxdb"]
CMD ["-config=/opt/influxdb/shared/config.toml"]
