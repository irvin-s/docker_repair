FROM ubuntu
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

ENV INFLUXDB_CONF=/etc/influxdb_conf.toml

RUN apt-get update
RUN apt-get install -y wget

RUN wget https://s3.amazonaws.com/influxdb/influxdb_0.10.1-1_amd64.deb
RUN dpkg -i influxdb_0.10.1-1_amd64.deb
RUN rm influxdb_0.10.1-1_amd64.deb

EXPOSE 8083
EXPOSE 8086

ADD ./run.sh ./run.sh
RUN chmod 755 ./run.sh
ADD ./influxdb_conf.toml $INFLUXDB_CONF

ENTRYPOINT ["./run.sh"]
