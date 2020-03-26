# InfluxDB
# @version 0.8.8
# @author Lorenzo Fontana <fontanalorenzo@me.com>
FROM centos:centos7

MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

RUN rpm -ivh https://s3.amazonaws.com/influxdb/influxdb-0.8.8-1.x86_64.rpm

EXPOSE 8083
EXPOSE 8086
EXPOSE 8084

ENTRYPOINT ["influxdb"]
