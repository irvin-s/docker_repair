FROM debian:jessie

RUN apt-get update && \
    apt-get -y -q install rsyslog && \
    mkdir /var/log/shared

COPY ./conf/rsyslog.conf /etc/rsyslog.conf


VOLUME [ "/var/log/shared", "/etc/rsyslog.d" ]
EXPOSE 514/tcp 514/udp

ENTRYPOINT ["rsyslogd"]
CMD ["-n",  "-f", "/etc/rsyslog.conf"]
