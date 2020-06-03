# InfluxDB
# @version 0.9.1.1
# @author Lorenzo Fontana <fontanalorenzo@me.com>
FROM centos:centos7

MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

RUN rpm -ivh https://s3.amazonaws.com/influxdb/influxdb-0.9.1-1.x86_64.rpm

RUN ln -s /opt/influxdb/influxd /usr/local/bin
RUN ln -s /opt/influxdb/influx /usr/local/bin

EXPOSE 8083
EXPOSE 8086
EXPOSE 8084
