FROM ubuntu:16.04
MAINTAINER TANABE Ken-ichi <nabeken@tknetworks.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y postfix rsyslog nagios-plugins && \
  cp /usr/share/postfix/main.cf.debian /etc/postfix/main.cf && \
  postconf -e smtpd_upstream_proxy_protocol=haproxy

EXPOSE 25

COPY run.sh /run.sh

CMD ["/run.sh"]
