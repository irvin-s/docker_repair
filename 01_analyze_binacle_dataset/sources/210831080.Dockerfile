# BUILDING
# docker build -t stuckless/crushftp:latest .

# Ubuntu 16.04
FROM phusion/baseimage:0.9.19

CMD ["/sbin/my_init"]

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

# The docker container version, not SageTV version
ENV CRUSHFTP_CONTAINER_VERSION="1.0.1"

ENV APP_NAME="CrushFTP Server"
ENV DEBIAN_FRONTEND=noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# add crush user and group
# RUN mkdir /var/opt/CrushFTP8_PC
RUN useradd -u 911 -U -d /var/opt/CrushFTP8_PC -s /bin/bash crushftp

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# libraries stuff
RUN set -x \
  && apt-get update \
  && apt-get install -y wget curl net-tools file \
    less vim software-properties-common unzip cifs-utils sudo

RUN set -x

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD init.d/10-adduser /etc/my_init.d/10-adduser
RUN chmod 755 /etc/my_init.d/10-adduser

ADD init.d/20-upgrade-crushftp /etc/my_init.d/20-upgrade-crushftp
RUN chmod 755 /etc/my_init.d/20-upgrade-crushftp

ADD init.d/30-setperms /etc/my_init.d/30-setperms
RUN chmod 755 /etc/my_init.d/30-setperms

ADD init.d/90-crushftp /etc/my_init.d/90-crushftp
RUN chmod 755 /etc/my_init.d/90-crushftp

ADD init.d/99-zmessage /etc/my_init.d/99-zmessage
RUN chmod 755 /etc/my_init.d/99-zmessage

# add the install
ADD CrushFTP8_PC.zip /tmp/

# how to add a service...
#RUN mkdir /etc/service/complete
#ADD services.d/99-complete /etc/service/complete/run
#RUN chmod 755 /etc/service/complete/run

VOLUME ["/var/opt/CrushFTP8_PC","/files"]

# WebServer
EXPOSE 8080
EXPOSE 9090
EXPOSE 9021
