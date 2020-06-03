# Starts InfluxDB

FROM fedora

MAINTAINER Harald Pehl <hpehl@redhat.com>

ENV PRE_CREATE_DB **None**
ENV INFLUXDB_INIT_USER root
ENV INFLUXDB_INIT_PWD root

# Install
RUN yum -y install tar wget sudo nginx supervisor 
RUN wget -q http://influxdb.s3.amazonaws.com/influxdb-0.9.1-1.x86_64.rpm && rpm -ivh influxdb-0.9.1-1.x86_64.rpm && rm influxdb-0.9.1-1.x86_64.rpm
RUN mkdir -p /opt/grafana && cd /opt/grafana && wget http://grafanarel.s3.amazonaws.com/grafana-1.9.0-rc1.tar.gz && tar xzvf grafana-1.9.0-rc1.tar.gz --strip 1 && rm grafana-1.9.0-rc1.tar.gz
RUN wget -q https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install pystache && rm get-pip.py
ADD prepare-and-run.sh /prepare-and-run.sh
RUN chmod +x /prepare-and-run.sh

# Configure
ADD supervisord.conf /etc/supervisord.conf
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD influx/run.sh /opt/influxdb/run.sh
RUN chmod +x /opt/influxdb/run.sh
ADD influx/config.toml /opt/influxdb/shared/config.toml
ADD grafana/* /opt/grafana/
RUN chmod +x /opt/grafana/config.py

RUN mkdir /data

EXPOSE 80
EXPOSE 8083
EXPOSE 8086

CMD ["/prepare-and-run.sh"]
