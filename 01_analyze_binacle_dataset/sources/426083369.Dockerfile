# Leaner build then Ubuntu
FROM debian:jessie

MAINTAINER Kyle Manna <kyle@kylemanna.com>

RUN apt-get update && apt-get install -y tahoe-lafs dnsutils openvpn busybox

RUN mkdir /tahoe && ln -s /tahoe /.tahoe

#RUN useradd -m -d /tahoe -s /bin/bash tahoe
#RUN mkdir -p /tahoe  && chown -R tahoe /tahoe
#USER tahoe

WORKDIR /tahoe

VOLUME ["/tahoe"]

CMD ["tahoe_node"]

#ADD etc/ /etc/
ADD bin/ /usr/local/bin/
RUN chmod -R a+x /usr/local/bin

