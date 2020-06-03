FROM ubuntu:latest
ENV TELEGRAF_CONF=/etc/telegraf.conf
RUN apt-get update
RUN apt-get install -y wget
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf_1.0.0_amd64.deb
RUN dpkg -i telegraf_1.0.0_amd64.deb
RUN rm telegraf_1.0.0_amd64.deb

ADD ./telegraf.conf $TELEGRAF_CONF
ADD ./run.sh ./run.sh
RUN chmod 755 ./run.sh

CMD ["./run.sh"]
