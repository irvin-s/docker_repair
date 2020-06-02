FROM ubuntu:latest
MAINTAINER Renan Gonçalves <renan.saddam@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y wget mysql-client
RUN wget -q https://downloads.powerdns.com/releases/deb/pdns-static_3.4.3-1_amd64.deb && \
	dpkg -i pdns-static_3.4.3-1_amd64.deb

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 80

ADD pdns.sql .
ADD start.sh .
RUN chmod +x start.sh

CMD ./start.sh
