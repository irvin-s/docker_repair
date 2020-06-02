FROM ubuntu:latest
MAINTAINER jamiesun <jamiesun.net@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get install -y pptpd iptables libfreeradius-client2 libfreeradius-client-dev supervisor
RUN apt-get clean all

# setup pptp

COPY pptp/pptpd.conf /etc/pptpd.conf
COPY pptp/ppp/pptpd-options /etc/ppp/pptpd-options

# setup freeradius-client

COPY radius/radiusclient.conf /etc/radiusclient/radiusclient.conf
COPY radius/servers /etc/radiusclient/servers
COPY radius/dictionary/dictionary.microsoft /etc/radiusclient/dictionary.microsoft
COPY radius/dictionary/dictionary.pppd /etc/radiusclient/dictionary.pppd
COPY radius/dictionary/dictionary /etc/radiusclient/dictionary

COPY supervisord.conf /etc/supervisord.conf


EXPOSE  1723

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-n","-c","/etc/supervisord.conf"]
