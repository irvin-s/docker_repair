FROM registry.aliyuncs.com/acs-sample/ubuntu:14.04
RUN apt-get update && apt-get install -y curl  && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY grafana-influxdb.sh /grafana-influxdb.sh
COPY Container-Activity.json /Container-Activity.json
ENV INFLUXDB_NAME cadvisor
CMD /grafana-influxdb.sh $INFLUXDB_NAME Container-Activity.json