FROM ubuntu:latest
ENV TELEGRAF_CONF=/etc/telegraf.conf
RUN apt-get update
RUN apt-get install -y wget
RUN wget http://get.influxdb.org/telegraf/telegraf_0.10.4.1-1_amd64.deb
RUN dpkg -i telegraf_0.10.4.1-1_amd64.deb

ADD ./telegraf.conf $TELEGRAF_CONF
ADD ./run.sh ./run.sh
RUN chmod 755 ./run.sh

CMD ["./run.sh"]
