#
# docker run -d --restart=always \
#   -v $PWD/conf:/etc/kapacitor.toml
#   -v /tasks:/var/lib/kapacitor/tasks
#   gianarb/kapacitor
#
FROM ubuntu
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

ENV KAPACITOR_CONF=/etc/kapacitor.toml
EXPOSE 9092

RUN apt-get update
RUN apt-get install -y wget

RUN wget https://dl.influxdata.com/kapacitor/releases/kapacitor_0.13.1_amd64.deb
RUN dpkg -i kapacitor_0.13.1_amd64.deb
RUN rm kapacitor_0.13.1_amd64.deb

ADD ./kapacitor.toml $KAPACITOR_CONF
ADD ./run.sh /opt/run.sh
RUN chmod 755 /opt/run.sh

CMD ["/opt/run.sh"]
