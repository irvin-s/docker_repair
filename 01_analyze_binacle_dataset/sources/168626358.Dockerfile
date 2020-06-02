#
#   Author: Rohith
#   Date: 2014-10-17 00:40:22 +0100 (Fri, 17 Oct 2014)
#
#  vim:ts=2:sw=2:et
#
FROM ubuntu
MAINTAINER <gambol99@gmail.com>

ENV APP base
ENV NAME base
ENV ENVIRONMENT prod

RUN apt-get update
RUN apt-get install -y curl wget vim supervisor
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64 -O /usr/bin/confd && chmod +x /usr/bin/confd
RUN mkdir -p \
  /dockerbase \
  /etc/confd/conf.d \
  /etc/confd/templates \
  /etc/supervisor/conf.d
RUN rm -f /etc/cron.daily/standard
ADD cleanup.sh dockerbase/cleanup.sh
ADD config/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD config/confd/confd.conf /etc/confd/confd.conf
RUN bash /dockerbase/cleanup.sh
