FROM busybox:1.24.1
MAINTAINER kpacha

ENV INFLUXDB_HOST=influxdb
ENV INFLUXDB_PORT=8086
ENV INFLUXDB_DB=mesos
ENV INFLUXDB_USER=root
ENV INFLUXDB_PWD=root

COPY ./mesos-influxdb-collector /mesos-influxdb-collector
COPY ./conf.hcl /conf.hcl

ENTRYPOINT ["/./mesos-influxdb-collector"]

CMD ["-c", "/conf.hcl"]
