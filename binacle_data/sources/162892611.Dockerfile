FROM debian:wheezy
MAINTAINER Jean-Christophe Saad-Dupuy <jc.saaddupuy@fsfe.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

# Install iceweasel dependencies
RUN apt-get install -y dnsmasq

EXPOSE 53

ADD dnsmasq.conf /etc/dnsmasq.conf

CMD ["dnsmasq", "-d", "-C", "/etc/dnsmasq.conf"]
