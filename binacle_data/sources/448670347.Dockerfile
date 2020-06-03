FROM elventear/supervisord:latest

MAINTAINER Pepe Barbe <dev@antropoide.net>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common 

RUN add-apt-repository -y ppa:transmissionbt/ppa && \
    apt-get update && \
    apt-get install -y transmission-daemon

ADD files/transmission-daemon /etc/transmission-daemon
ADD files/run_transmission.sh /run_transmission.sh

RUN mkdir -p /var/lib/transmission-daemon/incomplete && \
    mkdir -p /var/lib/transmission-daemon/downloads && \
    chown -R debian-transmission: /var/lib/transmission-daemon && \
    chown -R debian-transmission: /etc/transmission-daemon    

VOLUME ["/var/lib/transmission-daemon/downloads"]
VOLUME ["/var/lib/transmission-daemon/incomplete"]

EXPOSE 9091
EXPOSE 12345

USER debian-transmission

CMD ["/run_transmission.sh"]
