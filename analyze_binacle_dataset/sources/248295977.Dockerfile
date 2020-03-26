FROM ubuntu:16.04
MAINTAINER Zsolt Ero <zsolt.ero@gmail.com>

ADD . /bd_build

RUN /bd_build/prepare.sh && \
	/bd_build/system_services.sh && \
	/bd_build/utilities.sh && \
	/bd_build/cleanup.sh && \
    touch /etc/service/syslog-ng/down && \
    touch /etc/service/cron/down

WORKDIR /

ENV DEBIAN_FRONTEND teletype
ENV PYTHONIOENCODING UTF-8
ENV HOME /root

CMD ["/sbin/my_init"]
