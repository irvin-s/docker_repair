FROM ubuntu
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

RUN apt-get update
RUN apt-get install -y wget
RUN wget http://get.influxdb.org/influxdb_0.9.0-rc15_amd64.deb
RUN dpkg -i influxdb_0.9.0-rc15_amd64.deb

RUN rm influxdb_0.9.0-rc15_amd64.deb

EXPOSE 8083
EXPOSE 8086

ENTRYPOINT ["/opt/influxdb/influxd"]
