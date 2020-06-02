FROM centos:centos6
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

RUN \
  rpm -iUvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm &&\
  yum update -y &&\
  yum -y install httpd git wget tar

RUN \
  rm -f /etc/localtime &&\
  cp -p /usr/share/zoneinfo/Japan /etc/localtime

WORKDIR /opt
RUN \
  wget http://grafanarel.s3.amazonaws.com/grafana-1.9.1.tar.gz -O /opt/grafana.tar.gz &&\
  tar xvf grafana.tar.gz &&\
  mv /opt/grafana-1.9.1 /opt/grafana
     
ADD ./files/config.js /opt/grafana/config.js
ADD ./files/grafana.conf /etc/httpd/conf.d/grafana.conf
ADD ./files/setup_configs.sh /opt/grafana/setup_configs.sh
ADD ./files/run.sh /opt/grafana/run.sh

ENV INFLUXDB_HOST 172.17.42.1
ENV INFLUXDB_PORT 8086
ENV INFLUXDB_DB system
ENV INFLUXDB_USER admin
ENV INFLUXDB_PASSWORD admin
ENV INFLUXDB_GRAFANA_DB grafana

WORKDIR /opt/grafana

EXPOSE 8000
CMD ./setup_configs.sh && ./run.sh

