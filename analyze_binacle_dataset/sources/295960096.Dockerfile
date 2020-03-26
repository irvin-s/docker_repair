FROM ubuntu:16.04
MAINTAINER xenron <xenron@hotmail.com>

# ARG DEBIAN_FRONTEND=noninteractive

# init wheezy docker
RUN apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
  rm -rf /var/cache/debconf/*-old && rm -rf /var/lib/apt/lists/* && rm -rf /usr/share/doc/* && \
  apt-get dist-upgrade && \
  apt-get update -y && \
  echo "`cat /etc/issue.net` Docker Image - philcryer/min-wheezy - `date +'%Y/%m/%d'`" > /etc/motd

RUN apt-get install -y vim tar unzip dnsmasq wget net-tools  && \
  apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
  rm -rf /tmp

# dnsmasq configuration
ADD dnsmasq/* /etc/

# install serf
RUN  wget -q -o out.log -P /tmp/ https://releases.hashicorp.com/serf/0.7.0/serf_0.7.0_linux_amd64.zip && \
  rm -rf /bin/serf

RUN unzip /tmp/serf_0.7.0_linux_amd64.zip -d /bin && \
  rm /tmp/serf_0.7.0_linux_amd64.zip

# configure serf
ENV SERF_CONFIG_DIR /etc/serf
ADD serf/* $SERF_CONFIG_DIR/
ADD handlers $SERF_CONFIG_DIR/handlers
RUN chmod +x  $SERF_CONFIG_DIR/event-router.sh $SERF_CONFIG_DIR/start-serf-agent.sh

