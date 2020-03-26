FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install curl apt-transport-https
RUN echo "deb https://packagecloud.io/raintank/raintank/ubuntu/ trusty main" > /etc/apt/sources.list.d/raintank.list
RUN curl https://packagecloud.io/gpg.key | apt-key add -
RUN apt-get update && apt-get install -y software-properties-common supervisor
ENV LANG en_US.UTF-8
RUN locale-gen $LANG
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update && apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
RUN apt-get update
RUN apt-get install collectd=5.5.0-zrt12~trusty -y

COPY kafka.conf /etc/collectd/collectd.conf.d/kafka.conf
COPY write_graphite.conf /etc/collectd/collectd.conf.d/write_graphite.conf

ADD supervisor/collectd.conf /etc/supervisor/conf.d/

CMD ["supervisord", "-n"]
