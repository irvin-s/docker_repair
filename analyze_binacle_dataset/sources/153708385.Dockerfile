# Ubuntu dockerfile

FROM ubuntu:12.04

MAINTAINER gezpage@gmail.com

ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD files/sources.list /etc/apt/sources.list
ADD files/install.sh /root/install.sh
RUN /root/install.sh

EXPOSE 22

CMD ["/usr/bin/supervisord"]
